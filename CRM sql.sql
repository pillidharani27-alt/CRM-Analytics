create database CRM;
use crm;
Show tables;

									-- Opportunity Dashboard --
-- Total Opportunity
select count(*) as Tota_Opportunities from opportunities;

-- Expected Amount
select concat(round(sum(Amount) /100000, 2),' M') as Expected_Amount from opportunities;

-- Active Opportinities
select count(*) as Active_Opportunities from opportunities where stage not in ('closed won', 'closed lost');

-- Conversion Rate
select concat(round(count(case when Stage = 'Closed Won' then `Opportunity ID`end) * 100
 / count(`Opportunity ID`),2),' % ') as conversion_rate_percent from opportunities;

-- Win_Rate_percent
select concat(round(count(case when Stage = 'Closed Won' then `Opportunity ID`end) * 100
/ count( case when Stage in ('Closed Won','Closed Lost') then `Opportunity ID`end),2), ' %') as Win_Rate_Percent from Opportunities;

-- Loss_Rate_Percent
select concat(round(count(case when Stage = 'Closed Lost' then `Opportunity ID`end) * 100
/ count(case when Stage in ('Closed Won','Closed Lost') then `Opportunity ID`end), 2), ' %') as Loss_Rate_Percent from opportunities;

-- Open vs Won Vs Lost
select sum(case when Stage = 'Closed lost' then 1 else 0 end) as lost, 
sum(case when Stage = 'Closed won' then 1 else 0 end) as won, 
sum(case when stage not in ('closed won','closed lost') then 1 else 0 end) as active from opportunities;


-- Active vs Total Opportunities
select year(close_date_dt) as year, count(`Opportunity ID`) as Total_Opportunities,
count(case when Stage not in ('Closed Won','Closed Lost') then `Opportunity ID`
end) as Active_Opportunities from opportunities where close_date_dt between '2015-01-01' and '2019-12-31'
group by year(close_date_dt) order by year;

-- closed won vs Total Opportunities
select year(close_date_dt) as year, count(`Opportunity ID`) AS Total_Opportunities,
count(case when Stage = 'Closed Won' then `Opportunity ID`end) as closed_won
from opportunities where close_date_dt is not null and year(close_date_dt) between '2015-01-01' and '2020-12-31'
group by year(close_date_dt) order by year;

-- Closed Vs Total Closed
select year(close_date_dt) as year, count(case when Stage = 'Closed Won' then `Opportunity ID`end) as Closed_Won,
count(case when Stage in ('Closed Won','Closed Lost') then `Opportunity ID` end) as Total_Closed from opportunities 
where close_date_dt between '2015-01-01' and '2019-12-31' group by year(close_date_dt) order by year;

-- Opportunity by industry
select Industry,count(`Opportunity ID`) as Opportunity_Count from opportunities group by Industry order by Opportunity_Count desc;



                                           -- LEAD KPI'S --
-- Total Leads
select count(*) as Total_Leads from leads;

-- Converted Leads
select count(*) as Converted_Leads from leads where status = 'converted';

-- Lead Conversion Rate (%)
select concat(round((sum(case when status = 'converted' then 1 else 0 end) / count(*)) * 100,2), '%') 
as Lead_Conversion_Rate from leads;


-- Converted Opportunities
select count(*) as Converted_Opportunities from opportunities where stage = 'closed won';

-- Conversion Rate %
select concat(round((sum(case when stage = 'closed won' then 1 else 0 end) / count(*)) *100,2), '%') 
as conversion_rate from opportunities;

-- Lead by Source
select lead_source, count(*) as Total_Leads from leads group by lead_source order by total_Leads desc limit 10;

-- Leads by Industry
select industry, count(*) as total_leads from leads group by industry order by total_leads desc ;

-- Leads by Status
select status, count(*) as total_leads from leads group by status order by total_leads desc;


