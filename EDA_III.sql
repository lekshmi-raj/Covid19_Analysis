use `covid19_db`;

show tables;

select * from vaccination_details;


############ window operations #################

select
     v.`State/UTs`,
     round((v.`Total Vaccination Doses` / v.`Population`)*100,2) as Vacc_Cover_Pct,
     rank() over (order by(v.`Total Vaccination Doses`/v.`Population`) desc) as coverage_rank,
     ntile(4) over(order by(v.`Total Vaccination Doses`/v.`Population`) desc) as coverage_quartile
from covid19_db.vaccination_details v
order by coverage_rank;


select
     v.`State/UTs`,
     v.`Total Vaccination Doses`,
     sum(v.`Total Vaccination Doses`) over(order by v.`Total Vaccination Doses` desc
                                           rows between unbounded preceding and current row) as running_total
from covid19_db.vaccination_details v
order by `Total Vaccination Doses` desc;


select
     v.`State/UTs`,
     c.`Death Ratio`,
     round((v.`Total Vaccination Doses`/v.`Population`)*100,2) as Coverage_Pct,
     rank() over(partition by v.`State/UTs` order by c.`Death Ratio`) as death_rank,
     avg(c.`Death Ratio`) over() as national_avg_death
from covid19_db.vaccination_details v
join covid19_db.case_details c on v.`State/UTs`=c.`State/UTs`;


select distinct `State/UTs` from covid19_db.case_details;
select distinct `State/UTs` from covid19_db.vaccination_details;

set sql_safe_updates = 0;

update covid19_db.case_details
      set `State/UTs` = "Telangana"
      where `State/UTs` = "Telengana";
      
set sql_safe_updates = 1;