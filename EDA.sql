show databases;

use covid19_db;

show tables;

select * from covid19_db.summary;

###################  overview  ####################

select count(*) as total_states,
       count(distinct `State/UTs`) as unique_states,
       avg(Coverage_Pct) as avg_recovery,
       min(Coverage_Pct) as min_recovery,
       max(Coverage_Pct) as max_recovery
from covid19_db.summary;

##################  vaccination leaders  ####################

select `State/UTs`,Coverage_Pct as coverage
from covid19_db.summary
order by Coverage_Pct desc limit 5;

#################  deadliest states  #################

select `State/UTs`,format(Deaths,"#,##0") as Deaths,Death_Pct
from covid19_db.summary
order by Death_Pct desc limit 5;

#################  vaccination VS death_correlation  ##################

select
  case
	  when Coverage_Pct >= 60 then "High Recovery"
      when Coverage_Pct >= 45 then "Medium Recovery"
      else "Low Recovery"
   end as Vaccination_Group,
   count(*) as States,
   round(avg(Coverage_Pct),2) as Avg_Coverage,
   round(avg(Deaths/1000),0) as Avg_Deaths,
   round(avg(Death_Pct),2) as Avg_Death_Pct
from covid19_db.summary
group by 1
order by Avg_Coverage desc;

##################  national summary  #################

select count(*) as Total_States,
	   sum(Deaths) as Total_National_Deaths,
       round(avg(Deaths),2) as National_Avg_Deaths,
       min(Deaths) as National_Min_Deaths,
       max(Deaths) as National_Max_Deaths
from summary;

#################  data quality  ###############

select count(*) as Total_States, 
       sum(case when Coverage_Pct is null then 1 else 0 end) as Coverage_Group,
       sum(case when Deaths is null then 1 else 0 end) as Deaths_Group
from summary;