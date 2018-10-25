/****** Script for SelectTopNRows command from SSMS  ******/
ALTER TABLE [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
ADD Age_index int;
 
 update  [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
 set Age_index = 1
 where AGE>=0 and AGE <1

 update  [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
 set Age_index = 2
 where AGE>=1 and AGE <5

  update  [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
 set Age_index = 3
 where AGE>=5 and AGE <19

  update  [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
 set Age_index = 4
 where AGE>=19 and AGE <65

  update  [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
 set Age_index = 5
 where AGE>=65

  update  [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
 set Age_index = 7
 where AGE=999


--------------------------------------------------------------------------------------------------

ALTER TABLE [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE]
ADD MONTH_NOS INT;

UPDATE [ClaimData10_Kordestan].[dbo].[SAR_NOSKHE] SET MONTH_NOS = CAST(SUBSTRING(cast(DATE_NOS as nvarchar),5,2) AS INT)
WHERE LEN(DATE_NOS) = '8'

----------------------------------------------------------------------------------------------------
CREATE TABLE TestReport.dbo.FinalReportKordestan(
    Number  bigint,
    TotalCost  bigint ,
    DrugCode varchar(255),
    Gender varchar(25),
    AgeIndex int,
    Year varchar(25),
	Month varchar(25)
);

-------------------------------------------------------------------------------------------------------------------------------------------

insert INTO TestReport.dbo.FinalReportKordestan(Number,TotalCost,DrugCode,Gender,AgeIndex,Year,Month)
select
sum(t1.[TEDAD]),
sum(t1.[TOTAL]) ,
t1.[DRUG_CODE],
cast(t2.[SEX] as varchar) ,
t2.[Age_index] ,
Cast(t2.YEAR_NOS as varchar) ,
Cast(t2.MONTH_NOS as varchar)
FROM
[ClaimData10_Kordestan].[dbo].[NOSKHE_ITEM]  t1
INNER JOIN
[ClaimData10_Kordestan].[dbo].[SAR_NOSKHE] t2
ON t2.[CODE] = t1.[FK_SAR_NOS]
WHERE [DRUG_CODE] IS NOT NULL and YEAR_NOS>=1386 and YEAR_NOS<=1396
GROUP BY CUBE (t2.[SEX] ,
                t2.[Age_index],
                t1.[DRUG_CODE],
                t2.YEAR_NOS,
                t2.MONTH_NOS
                )