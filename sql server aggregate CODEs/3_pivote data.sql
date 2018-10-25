select u.[ID], u.[Location],u.[ServiceName],u.[ServiceCode],u.ServiceType,u.ServiceTypeKind
,u.ServiceTypeKindCode,u.[Age],u.[AgeIndex],u.[Gender],u.Measure, u.Value ,u.[Year],u.[Month],
u.[atc],u.[atc_l1],u.[atc_l2],u.[atc_l3],u.[atc_l4],u.[atc_label],u.[atc_l1_label],u.[atc_l2_label],u.[atc_l3_label],u.[atc_l4_label]
from [ClaimData2_Report].[dbo].[FinalReport] s
unpivot
(
  Value
  for Measure in (Number,TotalCost)
) u;
