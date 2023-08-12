--Data Cleaning

	select sum(CAST(sales as decimal)) as revenue,DEALSIZE 
	from 
	sales.dbo.sales_data_sample
	where POSTALCODE is NULL
	group by DEALSIZE;

	 update sales.dbo.sales_data_sample
	 set ADDRESSLINE2='Null'
	 where ADDRESSLINE2='';

	 update sales.dbo.sales_data_sample
	 set DEALSIZE='Small'
	 where DEALSIZE LIKE'%Small%'

	update sales.dbo.sales_data_sample
	 set DEALSIZE='Medium'
	 where DEALSIZE LIKE'%Medium%'


	 update sales.dbo.sales_data_sample
	 set DEALSIZE='Large'
	 where DEALSIZE LIKE'%Large%'

	select * from sales.dbo.sales_data_sample
	where CITY like'Level%'
	
	update sales.dbo.sales_data_sample
	set CITY='Australia'
	where CITY like '%Level 3'

	update sales.dbo.sales_data_sample
	set CITY='Australia'
	where CITY like '%Level 6'

	update sales.dbo.sales_data_sample
	set CITY='Australia'
	where CITY like '%Level 15'

	update sales.dbo.sales_data_sample
	set CITY='Melbourne'
	where STATE ='Melbourne'

	update sales.dbo.sales_data_sample
	set CITY='Chatswood'
	where STATE ='Chatswood'

	update sales.dbo.sales_data_sample
	set CITY='North Sydney'
	where STATE ='North Sydney'

	    select TERRITORY,POSTALCODE,COUNTRY from sales.dbo.sales_data_sample
		WHERE TERRITORY='Australia'
      
		update sales.dbo.sales_data_sample
		set STATE='Victoria'
		where POSTALCODE ='Victoria'
		
		update sales.dbo.sales_data_sample
		set STATE='Queensland'
		where POSTALCODE ='Queensland'
		
		 update sales.dbo.sales_data_sample
		set COUNTRY= 'Germany'
		where  COUNTRY ='80686'

		select sum(CAST(sales as decimal)) as revenue,COUNTRY FROM sales.dbo.sales_data_sample
		GROUP BY COUNTRY

