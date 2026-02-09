use `covid19_db`;

show tables;

select * from covid19_db.vaccination_details;

###########  analysing how many peoples takes vaccination  ###########
select `State/UTs` as State,
	   `Total Vaccination Doses` as Total_Vaccination,
       `Population` as Target_Population,
       round((`Total Vaccination Doses`/`Population`)*100,2) as Vacc_Cover_Pct
from covid19_db.vaccination_details;

###############  top 10 vaccination coverages by states  #################

select `State/UTs` as State,
	   `Total Vaccination Doses` as Total_Vaccination,
       `Population` as Target_Population,
       round((`Total Vaccination Doses`/`Population`)*100,2) as Vacc_Cover_Pct
from covid19_db.vaccination_details
order by Vacc_Cover_Pct desc limit 10;


############# dose wise vaccination progress #############

SELECT 'Dose 1 (All)' AS Dose_Category, SUM(`Dose1`) AS Total_Doses
FROM covid19_db.vaccination_details
UNION ALL
SELECT 'Dose 2 (All)' AS Dose_Category, SUM(`Dose 2`) AS Total_Doses  
FROM covid19_db.vaccination_details
UNION ALL
SELECT 'Dose 1 (15-18)' AS Dose_Category, SUM(`Dose 1 15-18`) AS Total_Doses
FROM covid19_db.vaccination_details
UNION ALL
SELECT 'Dose 2 (15-18)' AS Dose_Category, SUM(`Dose 2 15-18`) AS Total_Doses
FROM covid19_db.vaccination_details
UNION ALL
SELECT 'Dose 1 (12-14)' AS Dose_Category, SUM(`Dose 1 12-14`) AS Total_Doses
FROM covid19_db.vaccination_details
UNION ALL
SELECT 'Dose 2 (12-14)' AS Dose_Category, SUM(`Dose 2 12-14`) AS Total_Doses
FROM covid19_db.vaccination_details
UNION ALL
SELECT 'Boosters (18-59)' AS Dose_Category, SUM(`Precaution 18-59`) AS Total_Doses
FROM covid19_db.vaccination_details
ORDER BY total_doses DESC;

############ top 15 states by case severity ################

select
     v.`State/UTs`,
     c.`Total Cases`,
     c.`Deaths`,
     c.`Death Ratio`,
     v.`Total Vaccination Doses`,
     round((v.`Total Vaccination Doses` / v.`Population`)*100,2) as Vacc_Pct
from covid19_db.vaccination_details v left join covid19_db.case_details c on v.`State/UTs` = c.`State/UTs`
order by c.`Total Cases` desc
limit 15 ;




