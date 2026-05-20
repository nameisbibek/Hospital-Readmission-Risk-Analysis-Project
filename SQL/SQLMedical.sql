

-- create database
create database [Hospital Readmission Risk Analysis]

-- use database
use [Hospital Readmission Risk Analysis]

-- checking data values import
select * from hospital_readmissions


-- checking NULL values in the dataset
select 
	
	count(case when age is null  OR medical_specialty = '?' then 1 end)as MissingAge,
	count(case when time_in_hospital is null  OR medical_specialty = '?' then 1 end) as MissingTimeHospital,
	count(case when n_lab_procedures is null  OR medical_specialty = '?' then 1 end) as Missinglab,
	count(case when n_procedures is null  OR medical_specialty = '?' then 1 end) as missingProcedures,
	count(case when n_outpatient is null  OR medical_specialty = '?' then 1 end) as missingoutpatient,
	count(case when n_emergency is null  OR medical_specialty = '?' then 1 end) as missingemergency,
	count(case when medical_specialty is null  OR medical_specialty = '?' then 1 end) as MissingSpecialty,
	count(case when diag_1 is null  OR medical_specialty = '?' then 1 end) as missingdiag_1,
	count(case when diag_2 is null  OR medical_specialty = '?' then 1 end) as missingdiag_2,
	count(case when diag_3 is null  OR medical_specialty = '?' then 1 end) as diag_3,
	count(case when glucose_test is null  OR medical_specialty = '?' then 1 end) as missingglucose,
	count(case when A1Ctest is null  OR medical_specialty = '?' then 1 end) as missingA1Ctest,
	count(case when change is null  OR medical_specialty = '?' then 1 end) as missingchange,
	count(case when diabetes_med is null  OR medical_specialty = '?' then 1 end) as missingdiabetes,
	count(case when readmitted is null  OR medical_specialty = '?' then 1 end) as missingreadmitted

from hospital_readmissions


-- Total number of rows check
SELECT COUNT(*) AS TotalRows
FROM hospital_readmissions;



