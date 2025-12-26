--хранима€ процедура dbo.UI_FP_Payment_Split, котора€ по внесенным платежам в таблицу dbo.FD_Payments 
--будет расщепл€ть его на оплаты по конкретным счетам и услугам исход€ из заполненных строк в таблице dbo.FD_Bills

create procedure dbo.UI_FP_Payment_Split @LINK int, @N_Type bit
as
begin
	declare @F_Subscr int,
			@F_Payments int;
	declare @N_Amount money;

	declare @FD_Bills table(
		[LINK] [int] NOT NULL,
		[C_Number] [varchar](50) NULL,
		[F_Subscr] [int] NOT NULL,
		[C_Sale_Items] [varchar](50) NOT NULL,
		[D_Date] [date] NOT NULL,
		[N_Amount] [money] NOT NULL,
		[N_Amount_Rest] [money] NOT NULL,
		stat bit default 0 )

	--Ќаходим только что оплаченный счет
	select 
		 @F_Payments = [LINK]
		,@F_Subscr   = [F_Subscr]		
		,@N_Amount   = [N_Amount]
	from [FD_Payments]
	where LINK = @link

	insert into @FD_Bills(
			 [LINK]
			,[C_Number]
			,[F_Subscr]
			,[C_Sale_Items]
			,[D_Date]
			,[N_Amount]
			,[N_Amount_Rest]
			)
	select *
	from FD_Bills 
	where F_Subscr = @F_Subscr
		and N_Amount_Rest > 0
	order by D_Date 

	declare @NAmount money

	if(@N_Type = 0)
	begin	
					
		declare @id int
		declare @CSaleItems varchar(50)
		declare @NAmountRest money
		
		while exists(select 1 from @FD_Bills)
		begin
			--получаем первый элемент в неоплаченных начислени€х
			select top 1 @id = link, @CSaleItems = C_Sale_Items, @NAmount = N_Amount, @NAmountRest = N_Amount_Rest from @FD_Bills;
		
			set @N_Amount = @N_Amount - @NAmountRest;			
			if (@N_Amount <= 0)
			begin
				insert into [FD_Payment_Details] (
					[F_Payments], 
					[F_Bills],
					[C_Sale_Items],
					[N_Amount])
				select @F_Payments, @id, @CSaleItems, @NAmountRest - abs(@N_Amount)

				update b set N_Amount_Rest = abs(@N_Amount)
				from [FD_Bills] b
				where b.LINK = @id

				break;
			end;

			insert into [FD_Payment_Details] (
				[F_Payments], 
				[F_Bills],
				[C_Sale_Items],
				[N_Amount])
			select @F_Payments, @id, @CSaleItems, @NAmountRest
		
			update b set N_Amount_Rest = 0
			from [FD_Bills] b
			where b.LINK = @id

			delete from @FD_Bills where LINK = @id
		end; 

		 


	end

	if(@N_Type = 1)
	begin

		while exists(select 1 from @FD_Bills)
		begin
			--находим мес€ц и год начислений чтобы потом отобрать случаи дл€ проверки 
			declare @month varchar(2)
			declare @year varchar(4)
			select top 1 @year = year(D_Date), @month = month(D_Date)
			from @FD_Bills			
			group by year(D_Date), month(D_Date)

		
			declare @sum money
			select @sum = sum(N_Amount_Rest)
			from @FD_Bills
			where year(D_Date) = @year and month(D_Date) = @month				
			
			declare @N_Amount_ss money = @N_Amount
			set @N_Amount = @N_Amount - @sum;
						
			if(@N_Amount < 0)
			begin
				--сразу учитывает что при ѕропорциональном распределении в результате округлени€ будем тер€ть сотые части, 
				--по этому найдем разницу и добавим не достающие 
				;with bills as (
					select 
						LINK, 
						C_Sale_Items,
						N_Amount_Rest,
						round(@N_Amount_ss * (N_Amount_Rest / @sum), 2) as calc_amount,
						row_number() over (order by LINK desc) as rn_desc
					from @FD_Bills fb					
					where year(D_Date) = @year and month(D_Date) = @month
				)
				insert into [FD_Payment_Details] (
					[F_Payments], 
					[F_Bills],
					[C_Sale_Items],
					[N_Amount])
				select 
					@F_Payments, 
					LINK, 
					C_Sale_Items,
					case 
						when rn_desc = 1 then  
							@N_Amount_ss - isnull((
								select sum(calc_amount) 
								from bills
								where rn_desc > 1
							), 0)
						else calc_amount
					end as final_amount
				from bills



				;with bills as (
					select 
						LINK, 
						N_Amount_Rest,
						round(@N_Amount_ss * (N_Amount_Rest / @sum), 2) as calculated_amount,
						row_number() over (order by LINK desc) as rn_desc
					from @FD_Bills fb					
					where year(D_Date) = @year and month(D_Date) = @month
				)
				update b set N_Amount_Rest = 
					case 
						when cte.rn_desc = 1 then
							cte.N_Amount_Rest - (@N_Amount_ss - isnull((
								select sum(calculated_amount) 
								from bills ct2
								where ct2.rn_desc > 1
							), 0))
						else cte.N_Amount_Rest - cte.calculated_amount
					end
				from FD_Bills b
				join bills cte on b.LINK = cte.LINK


				
				break;
			end 

			insert into [FD_Payment_Details] (
				[F_Payments], 
				[F_Bills],
				[C_Sale_Items],
				[N_Amount])
			select @F_Payments, LINK, C_Sale_Items, fb.N_Amount_Rest
			from @FD_Bills fb					
			where year(D_Date) = @year and month(D_Date) = @month

			update b set N_Amount_Rest = 0
			from FD_Bills b 
			where year(D_Date) = @year and month(D_Date) = @month
			
			if(@N_Amount = 0)
			begin
				break;
			end 
			delete from @FD_Bills where link in (select LINK
												 from @FD_Bills
												 where year(D_Date) = @year and month(D_Date) = @month)
		end
	end;

	---если после всех распределений по начислени€м остаетс€ сумма (переплата), распредел€ем ее на последний мес€ц в детализацию платежей
		if (@N_Amount > 0)
		begin
			declare @mon varchar(2)
			declare @ye varchar(4)
			select top 1 @ye = year(D_Date), @mon = month(D_Date)
			from FD_Bills			
			where F_Subscr = @F_Subscr
			group by year(D_Date), month(D_Date)
			order by year(D_Date) desc, month(D_Date) desc
			
			declare @summ money
			select @summ = sum(N_Amount)
			from FD_Bills
			where 
				F_Subscr = @F_Subscr 
				and year(D_Date) = @ye 
				and month(D_Date) = @mon


			;with bills as (
				select 
					LINK, 
					C_Sale_Items,
					N_Amount,
					round(@N_Amount * (N_Amount / @summ), 2) as calculated_amount,					
					row_number() over (order by LINK) as rn
				from FD_Bills fb					
				where 
					F_Subscr = @F_Subscr 
					and year(D_Date) = @ye 
					and month(D_Date) = @mon
			)

			insert into [FD_Payment_Details] (
				[F_Payments], 
				[F_Bills],
				[C_Sale_Items],
				[N_Amount])
			select 
				@F_Payments, 
				LINK, 
				C_Sale_Items, 
				case 
					when rn = 1 then 
						@N_Amount - (select sum(calculated_amount) from bills where rn > 1)
					else calculated_amount
				end as final_amount
			from bills		
		
		end
END


--ѕроверка є4:
--комбинаци 2ух разных типов распределени€

BEGIN TRAN 

    DECLARE @LINK INT 

    INSERT dbo.FD_Payments
    SELECT 'ѕ-123', 1, '20190105', 200 

    SET @LINK = SCOPE_IDENTITY()

    EXEC dbo.UI_FP_Payment_Split @LINK = @LINK, @N_Type = 0

    INSERT dbo.FD_Payments
    SELECT 'ѕ-124', 1, '20190105', 220 

    SET @LINK = SCOPE_IDENTITY()

    EXEC dbo.UI_FP_Payment_Split @LINK = @LINK, @N_Type = 1

    SELECT * FROM dbo.FD_Bills WHERE F_Subscr = 1
    SELECT * FROM dbo.FD_Payment_Details

ROLLBACK

--ѕроверка є5:
--Ѕерем сумма больше чем начислено с типом 0, 
--при этом ожидаем что данные будут зафиксированны в таблице детализаци€ платежей и при начислении эта переплата будет учитыватьс€ 

BEGIN TRAN 

    DECLARE @LINK INT 

    INSERT dbo.FD_Payments
    SELECT 'ѕ-123', 1, '20190105', 6780 

    SET @LINK = SCOPE_IDENTITY()

    EXEC dbo.UI_FP_Payment_Split @LINK = @LINK, @N_Type = 0

    INSERT dbo.FD_Payments
    SELECT 'ѕ-124', 1, '20190105', 220 

    SET @LINK = SCOPE_IDENTITY()

    EXEC dbo.UI_FP_Payment_Split @LINK = @LINK, @N_Type = 1

    SELECT * FROM dbo.FD_Bills WHERE F_Subscr = 1
    SELECT * FROM dbo.FD_Payment_Details

ROLLBACK


--ѕроверка є6:
--Ѕерем сумма с копейками, чтобы посмотрет как будет отрабатывать пропорциональное распределение

BEGIN TRAN 

    DECLARE @LINK INT 

    INSERT dbo.FD_Payments
    SELECT 'ѕ-123', 1, '20190105', 780,78 

    SET @LINK = SCOPE_IDENTITY()

    EXEC dbo.UI_FP_Payment_Split @LINK = @LINK, @N_Type = 1

    SELECT * FROM dbo.FD_Bills WHERE F_Subscr = 1
    SELECT * FROM dbo.FD_Payment_Details

ROLLBACK
