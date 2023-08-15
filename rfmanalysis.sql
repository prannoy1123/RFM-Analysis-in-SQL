select* from sales.dbo.sales_data_sample


--EXPLORING DATA

SELECT SUM(CAST(SALES AS decimal)) AS REVENUE FROM sales.dbo.sales_data_sample
select distinct PRODUCTCODE status from sales.dbo.sales_data_sample
select distinct status from sales.dbo.sales_data_sample
select distinct YEAR_ID from sales.dbo.sales_data_sample
select distinct PRODUCTLINE from sales.dbo.sales_data_sample
select distinct COUNTRY from sales.dbo.sales_data_sample
select distinct TERRITORY from sales.dbo.sales_data_sample
select distinct dealsize from sales.dbo.sales_data_sample

--Data Analysis

select productline,SUM(CAST(SALES AS decimal)) AS REVENUE from sales.dbo.sales_data_sample
group by PRODUCTLINE
order by 2 desc --Classic cars has the largest revenue by product line follwed by vintage cars and motorcycle product category

select territory,SUM(CAST(SALES AS decimal)) AS REVENUE from sales.dbo.sales_data_sample
group by TERRITORY
order by 2 desc -- EMEA has the largest sales in terms of region followed by North America & APAC

select YEAR_ID,SUM(CAST(SALES AS decimal)) AS REVENUE from sales.dbo.sales_data_sample
group by YEAR_ID
order by 2 desc -- Year 2004 has the largest sales, followed by a dip in sales in 2005

select DISTINCT MONTH_ID FROM sales.dbo.sales_data_sample
WHERE YEAR_ID=2005 -- Year 2005 has only 5 operating months as compared to 12 month sales in past years, so sales are low.

select DEALSIZE,SUM(CAST(SALES AS decimal)) AS REVENUE from sales.dbo.sales_data_sample
group by DEALSIZE
order by 2 desc -- Medium size deals have generated the highest revenue followed by small size deals.

select month_id, SUM(CAST(SALES AS decimal)) AS REVENUE, count(ordernumber) as Frequency from sales.dbo.sales_data_sample
where YEAR_ID=2004
group by MONTH_ID
order by 2 desc -- November is the best month in the year 2003, resulted in highest sales by month,same for every year

select month_id, productline,SUM(CAST(SALES AS decimal)) AS REVENUE, count(ordernumber) as Frequency from sales.dbo.sales_data_sample
where YEAR_ID=2003 and MONTH_ID=11
group by MONTH_ID,PRODUCTLINE
order by 3 desc -- In the Month of November, the highest sales item is Classic cars followed by Vintage cars , which are originally the two highest sales productline items

--Customer segmentation based on RFM analysis
drop table if exists #rfm;
with rfm_ as   -- Created a CTE for better analysis
(
select CUSTOMERNAME,SUM(CAST(SALES AS decimal)) AS Monetary_Value,
AVG(CAST(SALES AS decimal)) AS Average_Monetary_value,
count(ordernumber) AS Frequency,
max(orderdate) AS Last_Order_Date,
(select max(orderdate) from sales.dbo.sales_data_sample) AS Max_Order_Date,
DATEDIFF(DD, max(orderdate),(select max(orderdate) from sales.dbo.sales_data_sample)) AS Recency
from sales.dbo.sales_data_sample
group by customername  -- Here we are summarizing the table with the column required for RFM, Recency will be calculated by taking difference beteen max order date & last order date

),
rfm_data as
(
select a.*,
NTILE(4) over (order by recency) AS rfm_recency,
NTILE(4) over (order by Frequency) AS rfm_frequency,
NTILE(4) over (order by Monetary_Value) AS rfm_monetary_value
from rfm_ AS a
 )
select b.*,
(rfm_recency+rfm_frequency+rfm_monetary_value) AS Aggregate_Score
into #rfm
from rfm_data b

select CUSTOMERNAME,
case 
    when Aggregate_Score >9 then 'Good_Customer'
	when Aggregate_Score between 6 and 8 then 'New Customer'
	when  Aggregate_Score <6 then 'Churned Customer'
	end AS Customer_Segmentation
 from #rfm





