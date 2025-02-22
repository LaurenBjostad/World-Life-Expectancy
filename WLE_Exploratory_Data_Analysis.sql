# World Life Expectancy Project (EDA)

Select *
FROM `world_life_expectancy`.`world_life_expectancy`
;

#Largest shift in life expectancy
Select 
	country
    ,min(Lifeexpectancy)
    ,max(Lifeexpectancy)
    , round(max(Lifeexpectancy) - min(Lifeexpectancy),1) life_increase_15_yr
FROM `world_life_expectancy`.`world_life_expectancy`
Group by country
having min(Lifeexpectancy) <> 0
	and max(Lifeexpectancy) <> 0
Order by country DESC
;

#average life expectancy per year
SELECT
	Year
    ,round(AVG(Lifeexpectancy),2) avg_life
FROM `world_life_expectancy`.`world_life_expectancy`
Group by Year
Order by Year DESC
;

#Correlation

Select
	Country
	,round(AVG(Lifeexpectancy),2) avg_life
    ,round(AVG(GDP),2) avg_GDP
FROM `world_life_expectancy`.`world_life_expectancy`
where gdp <> 0
	and Lifeexpectancy <> 0
Group by Country
Order by avg_GDP DESC
;

#high & low GDP
SELECT
	SUM(CASE WHEN GDP >= 1500 THEN 1 ELSE 0 END) High_GDP_Count
    ,round(AVG(CASE WHEN GDP >= 1500 THEN  Lifeexpectancy ELSE null END),2) High_AVG_Life
    ,SUM(CASE WHEN GDP <= 1500 THEN 1 ELSE 0 END) Low_GDP_Count
    ,round(AVG(CASE WHEN GDP <= 1500 THEN  Lifeexpectancy ELSE null END),2) Low_AVG_Liefe
FROM `world_life_expectancy`.`world_life_expectancy`
;

#status
SELECT
	status
    ,round(AVG(Lifeexpectancy),2) AVG_Life
FROM `world_life_expectancy`.`world_life_expectancy`
Group by status
;

SELECT
	status
    ,count(distinct country) country_count
    ,round(AVG(Lifeexpectancy),2) AVG_Life
FROM `world_life_expectancy`.`world_life_expectancy`
Group by status

#BMI

Select
	Country
	,round(AVG(Lifeexpectancy),2) avg_life
    ,round(AVG(BMI),2) avg_BMI
FROM `world_life_expectancy`.`world_life_expectancy`
where BMI <> 0
	and Lifeexpectancy <> 0
Group by Country
Order by avg_BMI ASC
;

Select 
	country
    , year
    , Lifeexpectancy
    , adultmortality
    , sum(adultmortality) over (Partition by country Order by Year) rolling_sum_AM
FROM `world_life_expectancy`.`world_life_expectancy`
Where country like 'United States%'
;
