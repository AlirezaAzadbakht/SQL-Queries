DECLARE @ageI nvarchar(255) = '6' 
DECLARE @sexI nvarchar(255) ='0'
DECLARE @yearI nvarchar(255) ='1386'
DECLARE @MonthI nvarchar(255) ='1'
DECLARE @DrugI nvarchar(255) = '1'


DECLARE @LOC nvarchar(255)='Zanjan' 

DECLARE @sexLabel nvarchar(255)
DECLARE @sexV1 nvarchar(255)
DECLARE @sexV2 nvarchar(255)

DECLARE @ageV1 nvarchar(255)
DECLARE @agev2 nvarchar(255)

DECLARE @AgeRange int =6 
DECLARE @Sex int =3
DECLARE @Years int =1396
DECLARE @Months int =12
DECLARE @DrugCat int =5

WHILE @DrugI <= @DrugCat
BEGIN

	WHILE @sexI <= @Sex
	BEGIN
	
		WHILE @yearI <= @Years
		BEGIN
		
			WHILE @MonthI <= @Months
			BEGIN
			
				WHILE @ageI <= @AgeRange
				BEGIN


					IF @sexI ='1'
						SELECT @sexV1 = '0' , @sexV2 ='0' ,@sexLabel ='Male'
					IF @sexI ='2'
						SELECT @sexV1 = '1' , @sexV2 ='1' ,@sexLabel ='Female'
					IF @sexI ='3'
						SELECT @sexV1 = '0' , @sexV2 ='1' ,@sexLabel ='Both'

					IF @ageI ='1'
						SELECT @ageV1 = '0' , @ageV2 ='1' 
					IF @ageI ='2'
						SELECT @ageV1 = '1' , @ageV2 ='5'
					IF @ageI ='3'
						SELECT @ageV1 = '5' , @ageV2 ='19'
					IF @ageI ='4'
						SELECT @ageV1 = '19' , @ageV2 ='64'
					IF @ageI ='5'
						SELECT @ageV1 = '64' , @ageV2 ='999'
					IF @ageI ='6'
						SELECT @ageV1 = '0' , @ageV2 ='999'


					INSERT INTO [TestReport].[dbo].[REPORT] ([DRUG_CODE] ,[SEX], [LOC] , Ageindex,[YEAR] , [MONTH] ,[DRUGKIND],[NUMBER] ,[TOTAL_COST]    ) 
					SELECT 
						[DRUG_CODE] ,@sexLabel AS SEX ,@LOC AS LOC, @ageI AS Ageindex , @yearI AS YEAR , @MonthI AS MONTH , [ClaimData].[dbo].[DRUGSMASTER].[DRUGKIND] AS DRUGKIND,
						SUM( [TEDAD] ) AS NUMBER , SUM ( [TOTAL]*[TEDAD] )AS [TOTAL_COST]
						FROM
						(
						SELECT
						[ClaimData1_Zanjan].[dbo].[SAR_NOSKHE].[SEX] ,
						[ClaimData1_Zanjan].[dbo].[SAR_NOSKHE].[AGE] ,
						[ClaimData1_Zanjan].[dbo].[NOSKHE_ITEM].[TEDAD],
						[ClaimData1_Zanjan].[dbo].[NOSKHE_ITEM].[TOTAL],
						[ClaimData1_Zanjan].[dbo].[SAR_NOSKHE].[Year],
						[ClaimData1_Zanjan].[dbo].[SAR_NOSKHE].[Month],
						[ClaimData1_Zanjan].[dbo].[NOSKHE_ITEM].[DRUG_CODE] 
					FROM
						[ClaimData1_Zanjan].[dbo].[SAR_NOSKHE] 
					INNER JOIN [ClaimData1_Zanjan].[dbo].[NOSKHE_ITEM] ON [ClaimData1_Zanjan].[dbo].[SAR_NOSKHE].[CODE] = [ClaimData1_Zanjan].[dbo].[NOSKHE_ITEM].[FK_SAR_NOS] 
						)a
					INNER JOIN [ClaimData].[dbo].[DRUGSMASTER] ON [ClaimData].[dbo].[DRUGSMASTER].[MASTERCODE] = a.[DRUG_CODE] 
					WHERE 
						[SEX] BETWEEN @sexV1 AND @sexV2
						AND [Year]=@yearI
						AND [Month]=@MonthI
						AND [DRUGKIND]=@DrugI
						AND ([AGE] BETWEEN @ageV1 AND @agev2)
						AND [AGE] <> @ageV2
		
					GROUP BY
					[DRUG_CODE] , [DRUGKIND]

					SET @ageI = @ageI +1 
					END
					SET @ageI='1'

			SET @MonthI = @MonthI +1 
			END
			SET @MonthI='1'

		SET @yearI= @yearI +1 
		END
		SET @yearI='1386'

	SET @sexI = @sexI +1 
	END
	SET @sexI = '0'

SET @DrugI = @DrugI +1 
END	

			