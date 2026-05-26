

-- create database
create database [Hospital Readmission Risk Analysis]

-- use database
use [Hospital Readmission Risk Analysis]


-- checking the table data
select * from hospital_readmissions 

-- checking NULL values 1 column at a time
select count(*) as MissingAge
from hospital_readmissions
where age is NULL

-- checking NULL values in the dataset in multiple column
select 
	
	count(case when age is null then 1 end)as MissingAge,
	count(case when time_in_hospital is null then 1 end) as MissingTimeHospital,
	count(case when n_lab_procedures is null then 1 end) as Missinglab,
	count(case when n_procedures is null  then 1 end) as missingProcedures,
	count(case when n_outpatient is null then 1 end) as missingoutpatient,
	count(case when n_emergency is null  then 1 end) as missingemergency,
	count(case when medical_specialty is null  then 1 end) as MissingSpecialty,
	count(case when diag_1 is null then 1 end) as missingdiag_1,
	count(case when diag_2 is null then 1 end) as missingdiag_2,
	count(case when diag_3 is null  then 1 end) as diag_3,
	count(case when glucose_test is null  then 1 end) as missingglucose,
	count(case when A1Ctest is null then 1 end) as missingA1Ctest,
	count(case when change is null  then 1 end) as missingchange,
	count(case when diabetes_med is null then 1 end) as missingdiabetes,
	count(case when readmitted is null then 1 end) as missingreadmitted

from hospital_readmissions


-- checking distinct values
	-- Checking distinct Medical specialty values
	select distinct medical_specialty
	from hospital_readmissions

	-- Checking distinct diag1 values
	select distinct diag_1
	from hospital_readmissions


-- Total number of rows check
SELECT COUNT(*) AS TotalRows
FROM hospital_readmissions;


-- if there were NULL values then could be updated by following example
update hospital_readmissions
set time_in_hospital = 'Unknown'
where time_in_hospital is NULL

	-- ## no NULL values so its good here


-- checking duplicates
SELECT *,
       COUNT(*) AS DuplicateCount
FROM hospital_readmissions
GROUP BY
    age,time_in_hospital,n_lab_procedures,n_procedures,n_medications, n_outpatient,n_inpatient, n_emergency, medical_specialty, diag_1,diag_2, diag_3, glucose_test, A1Ctest, change, diabetes_med, readmitted
HAVING COUNT(*) > 1;

	-- ## No duplicates found.


-- checking what/number medical_specialty patients are having diabetes_med?

-- checking and knowing column
select distinct diabetes_med
from hospital_readmissions

	-- ## it is 0 (not taking) or 1 (taking)

-- checking
SELECT
    medical_specialty as MedicalType,
    COUNT(*) as TotalPatients
FROM hospital_readmissions
WHERE diabetes_med = '1'
GROUP BY medical_specialty
ORDER BY TotalPatients DESC;

	-- ## "Missing" type has highest 9462 and "Surgery" type has lowest 932 people taking diabetes med.


-- Readmission Risk analysis (which age group is visiting hospital frequently?)

--inspecting the column
select distinct age
from hospital_readmissions
order by age

	-- ## age group is [40-50), [50-60)...[90-100)


-- sum of different age groups staying in hospital
select age, sum(time_in_hospital) as 'Total hospital stay'
from hospital_readmissions
Group by age
order by 'Total hospital stay' desc

	-- ## [70-80) age stayed more days 31444 and [90-100) stayed less days 3572


-- Number of patient in different age groups readmitted in the hospital
select age, count(*) as 'Total Readmitted Patient'
from hospital_readmissions
where readmitted = '1'
group by age
order by 'Total Readmitted Patient' desc

	-- ## [70-80) has the most 3336 and [90-100) has less 316 readmitted patient


-- Calculating Readmission Rate by Medical Specialty
-- Readmission Rate = (Readmission Patient/ Total patient) * 100

	-- checking total patients per speciality
	select medical_specialty, count(*) as TotalPatients
	from hospital_readmissions
	group by medical_specialty
	order by TotalPatients desc

	-- checking readimission patients per speciality
	select medical_specialty, count(*) as PatientsReadmited
	from hospital_readmissions
	where readmitted = 1
	group by medical_specialty
	order by PatientsReadmited desc

	-- calculating Readmission Rate
	select medical_specialty, count(*) as TotalPatient,
		count(case when readmitted = 1 then 1 end) as ReadmittedPatients,
		Count(case when readmitted = 1 then 1 end)*100/count(*) as ReadmissionRate
	from hospital_readmissions
	group by medical_specialty
	order by TotalPatient desc

-- ## "Emergency/Family" has highest readmission rate = 49 and "Surgery/Other" has lowest = 41
