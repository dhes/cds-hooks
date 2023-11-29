I have created bits and pieces of CQL content over the last couple of years. Thinking in a broader context of implementation, I am summarizing what I have done and how I plan to move forward. 

This project brings together cql code from eight clinical reminders. Please keep in mind that ll of this code is intended for use in a primary care office at the point of care. 

|Title|source|repository/link|code|IG|
|---|---|---|---|---|
|AAA Screening|me|abdominal-aortic-aneurysm-screening|||
|Alcohol Screening|me|alcohol-screening|||
|ASCVD Risk Assessment|CDS Connect Million Hearts|Prediabetes and Type 2 Diabetes: Part One, Screening|https://cds.ahrq.gov/sites/default/files/cds/artifact/logic/2021-09/Million_Hearts_Baseline_10_Year_ASCVD_Risk_FHIRv401_v1.0.0_CQL.zip|https://cds.ahrq.gov/cdsconnect/artifact/cmss-million-heartsr-model-longitudinal-ascvd-risk-assessment-tool-baseline-10|
|Colon Cancer Screening|me|colon-cancer-screening|||
|CVD Prevention|CDS Connect: Healthy Diet and Physical Activity for CVD Prevention||https://cds.ahrq.gov/sites/default/files/cds/artifact/logic/2023-08/USPSTFDietAndActivityForCVDPreventionInAdultsFHIRv401_v2.1.0_CQL.zip|https://cds.ahrq.gov/cdsconnect/artifact/healthy-diet-and-physical-activity-cvd-prevention-adults-cardiovascular-risk|
|Diabetes Screening|me|diabetes-screening|||
|Diabetes Screening CDS Connect|CDS Connect:Prediabetes and Type 2 Diabetes: Part One, Screening||https://cds.ahrq.gov/sites/default/files/cds/artifact/logic/2023-08/USPSTFPrediabetesAndType2DiabetesPart1ScreeningFHIRv401_v2.1.0_CQL.zip|https://cds.ahrq.gov/cdsconnect/artifact/prediabetes-and-type-2-diabetes-part-one-screening|
|Colonoscopy Surveillance|me|CQL-testing-framework|||

Then there's ColonoscopyPolyp which is the IG for "CQL-testing-framework" (the badly named coloscoyp surveillance test suite). 

I have two entries for diabetes screening because I seem to have my own version of diabetes-screening and I'm not sure how much it reflects the CDS Connect version. I actually have two personal repositories named diabetes-screening and diabetes-screening-cds-connect. 

All of this fits within a broader implementation strategy championed by the American Cancer Society's [Closing Gaps in Cancer Screening](https://prescancerpanel.cancer.gov/report/cancerscreening/Part2Goal4.html). This President's Cancer Panel document outlines a multi-stakeholder strategy for broader adoption of CDS technology for *cancer* screening*. I plan to extend  the spirit of this report to screening in general. Thus from the example listed above I will focus all of those that have 'screening' in the title, plus *ASCVD Risk Assessment* because it is actually screening for high ASCVD risk. 

Which of these has a working test suite? 

| Rule |# test cases|runs?|all pass?|IG status|
|---|---|---|---|---|
|AAA Screening|16|yes|yes|repository created|
|Alcohol Screening|51|yes|no|nothing yet|
|ASCVD Risk Assessment|2|no||nothing yet|
|Colon Cancer Screening|16|no||nothing yet|
|CVD Prevention|194|no||nothing yet|
|Diabetes Screening|17|no||nothing yet|
|Diabetes Screening CDS Connect|1194|no||nothing yet|
|Colonoscopy Surveillance|6|yes|no|detailed draft|

Please note that the repository that holds the ColonoscopyPolyp tests is called CQL-testing framework. Sorry.
