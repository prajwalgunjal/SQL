create database Importdb
use Importdb


----------------------------Basic Commands----------------------------------
select * from dbo.Mental_Health_Care
select * from dbo.Public_School

select * from dbo.Public_School where SCH_NAME = 'ojai Unified'
select * from dbo.Public_School where SCH_NAME = 'ojai Unified' order by SCH_NAME
select top 10 * from dbo.Public_School 
select distinct(SCH_NAME) from dbo.Public_School 
select distinct(SCH_NAME) from dbo.Public_School order by SCH_NAME offset 10 rows
select * from Public_School where NCESSCH >12617 and NCESSCH <12631
select * from Public_School where NCESSCH between 12617 and 12631

select * from Public_School where SCH_NAME like 'o%'



-----------------------------store procedure ------------------------------

create procedure espDisplayall
as
begin 
select * from dbo.Public_School
end

exec espDisplayall

-----------------------------cte---------------------------------------------
with cte_Display
as
(select * from dbo.Public_School where SCH_NAME = 'ojai Unified')

select * from cte_Display

-------------------------------Function___________________________
alter function DisplayByYear()
returns table
as 
return 
select * from dbo.Public_School where STABR = '2020-2021'

select * from DisplayByYear()



alter function DisplayByYear(
@Model_year varchar
)
returns table
as 
return 
select * from dbo.Public_School where STABR = @Model_year

select * from DisplayByYear('2020-2021')

-------------------------------------------view-------------------------------------

create view dbo.DisplayView
as 
select * from dbo.Public_School where SCH_NAME = 'ojai Unified';

select * from dbo.DisplayView

























-------------------------------------Hospital----------------------------



---------------------Basic -------------------------------
select * from dbo.Mental_Health_Care

select * from dbo.Mental_Health_Care where State = 'United States'
select * from dbo.Mental_Health_Care where State = 'United States' order by SCH_NAME
select top 10 * from dbo.Mental_Health_Care 
select distinct(State) from dbo.Mental_Health_Care 
select distinct(State) from dbo.Mental_Health_Care order by State offset 10 rows

select * from Mental_Health_Care where State like 'A%'
