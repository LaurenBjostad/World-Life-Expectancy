select * From `world_life_expectancy`.`world_life_expectancy`

#FINDING DUPLICATE COUNTRY/YEAR RECORDS
SELECT
	Country
    ,Year
    ,count(concat(Country, Year)) as dupe_count
From `world_life_expectancy`.`world_life_expectancy`
Group by Country, Year, concat(Country, Year)
HAVING DUPE_COUNT > 1
;

Select row_id
From (
	SELECT
		row_id
		,concat(Country, Year) as dupe_count
		, row_number() over (partition by concat(Country, Year) Order by concat(Country, Year)) as row_num
	From `world_life_expectancy`.`world_life_expectancy`
) as new_table
where row_num >1

#remove duplicates
DELETE From `world_life_expectancy`.`world_life_expectancy`
where 
	Row_ID in (
	Select row_id
	From (
		SELECT
			row_id
			,concat(Country, Year) as dupe_count
			, row_number() over (partition by concat(Country, Year) Order by concat(Country, Year)) as row_num
		From `world_life_expectancy`.`world_life_expectancy`
	) as new_table
	where row_num >1
	)

#Cleaning Status Column
select * 
From `world_life_expectancy`.`world_life_expectancy`
where status = '';

select Distinct(status) 
From `world_life_expectancy`.`world_life_expectancy`
where status <> '';

select Distinct(country) 
From `world_life_expectancy`.`world_life_expectancy`
Where status = 'Developing'


#updating status
Update `world_life_expectancy`.`world_life_expectancy` w1
JOIN `world_life_expectancy`.`world_life_expectancy` w2
	on w1.country = w2.country
SET w1.status = 'Developing'
where w1.status = ''
	and w2.status <> ''
    and w2.status = 'Developing'
;

Update `world_life_expectancy`.`world_life_expectancy` w1
JOIN `world_life_expectancy`.`world_life_expectancy` w2
	on w1.country = w2.country
SET w1.status = 'Developed'
where w1.status = ''
	and w2.status <> ''
    and w2.status = 'Developed'
;
