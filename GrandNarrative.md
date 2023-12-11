## Overview

I have created bits and pieces of CQL content over the last couple of years. Thinking in a broader context of implementation, I am summarizing what I have done and how I plan to move forward. 

This project brings together cql code from eight clinical reminders. Please keep in mind that ll of this code is intended for use in a primary care office at the point of care. 

|Title|source|repository/link|code|IG|
|---|---|---|---|---|
|AAA Screening|me|abdominal-aortic-aneurysm-screening|||
|Alcohol Screening|me|alcohol-screening|||
|Alcohol Screening CDS Connect|https://github.com/asbi-cds-tools||||
|ASCVD Risk Assessment|CDS Connect Million Hearts|Prediabetes and Type 2 Diabetes: Part One, Screening|https://cds.ahrq.gov/sites/default/files/cds/artifact/logic/2021-09/Million_Hearts_Baseline_10_Year_ASCVD_Risk_FHIRv401_v1.0.0_CQL.zip|https://cds.ahrq.gov/cdsconnect/artifact/cmss-million-heartsr-model-longitudinal-ascvd-risk-assessment-tool-baseline-10|
|Colon Cancer Screening|me|colon-cancer-screening|||
|CVD Prevention|CDS Connect: Healthy Diet and Physical Activity for CVD Prevention||https://cds.ahrq.gov/sites/default/files/cds/artifact/logic/2023-08/USPSTFDietAndActivityForCVDPreventionInAdultsFHIRv401_v2.1.0_CQL.zip|https://cds.ahrq.gov/cdsconnect/artifact/healthy-diet-and-physical-activity-cvd-prevention-adults-cardiovascular-risk|
|Diabetes Screening|me|diabetes-screening|||
|Diabetes Screening CDS Connect|CDS Connect:Prediabetes and Type 2 Diabetes: Part One, Screening||https://cds.ahrq.gov/sites/default/files/cds/artifact/logic/2023-08/USPSTFPrediabetesAndType2DiabetesPart1ScreeningFHIRv401_v2.1.0_CQL.zip|https://cds.ahrq.gov/cdsconnect/artifact/prediabetes-and-type-2-diabetes-part-one-screening|
|Colonoscopy Surveillance|me|CQL-testing-framework|||

Then there's ColonoscopyPolyp which is the IG for "CQL-testing-framework" (the badly named coloscopy surveillance test suite). 

I have two entries for diabetes screening because I seem to have my own version of diabetes-screening and I'm not sure how much it reflects the CDS Connect version. I actually have two personal repositories named diabetes-screening and diabetes-screening-cds-connect. 

All of this fits within a broader implementation strategy championed by the American Cancer Society's [Closing Gaps in Cancer Screening](https://prescancerpanel.cancer.gov/report/cancerscreening/Part2Goal4.html). This President's Cancer Panel document outlines a multi-stakeholder strategy for broader adoption of CDS technology for *cancer* screening*. I plan to extend  the spirit of this report to screening in general. Thus from the example listed above I will focus all of those that have 'screening' in the title, plus *ASCVD Risk Assessment* because it is actually screening for high ASCVD risk. 

## Functional Status

Which of these has a working test suite? 

| Rule |# test cases|runs?|all pass?|IG status|github url|
|---|---|---|---|---|---|
|AAA Screening|16|yes|yes|repository created||
|Alcohol Screening|51|yes|no|nothing yet|https://github.com/asbi-cds-tools|
|ASCVD Risk Assessment|2|no||nothing yet||
|Colon Cancer Screening|16|no||nothing yet||
|CVD Prevention|194|no||nothing yet||
|Diabetes Screening|17|no||nothing yet||
|Diabetes Screening CDS Connect|1194|no||nothing yet||
|Colonoscopy Surveillance|6|yes|no|detailed draft||

Please note that the repository that holds the ColonoscopyPolyp tests is called CQL-testing framework. Sorry.

### AAA Screening

My simple code runs and tests so I'm moving on. 

### Alcohol Screening

Here I clone CQL-Testing and added the CQL and test code from the IG for Alcohol Screening CDS Connect. I'm going to set this aside for now to focus on the full CDS connect version. 

### Alcohol Screening CDS Connect

This is a  complicated project with more moving parts. The github url points to six repositories, five of which provides have code which must be running for the whole thing to work. What's different about this project when compared to AAA screening is that AAA screening only identifies candidates for screening. It is up to the clinician to recognized that screening is warranted and take action, presumably to discuss it with the patient and order the test. In the case of Alcohol Screening: once it identifies someone who needs screening, it proceeds to administer a questionnaire. When that is done it  calculates a risk score, adds it to the chart and then suggests and action which in this case is frames as a 'brief intervention'. Because of all of these steps it may take a while to get my instance working. 

#### blow by blow

Here I am documenting my trials and tribulations. Because *alcohol screening CDS connect* is stored in github as the sole content of a pseudonymous user *asbi-cds-tools* my simplest solution is to store this all under *alcohol-screening-cds-connect* directory. However in my github repository the submodules are stored as repositories. 

As of 2023-11-29 five of the six repositories are unaltered from the original. The exception is *asbi-screening-app* which I downloaded and altered in 2022. 

So now the grand narrative focuses on getting asbi-alcohol-screening to work. 

Not for the faint of heart. There are some easy fixes but it two a full day to find them. 

For *asbl-testing-server* there was a pull that broke a number of things. Fairly easily fixed by just loadin the previous pull (the last in 2021). The problem was the *lowdb* dependency, which was updated from 1 point something to 5 point something. The 5 point somethign version is pure ECS and doesn't play well with the rest of the code.

For *asbi-screening-app* just use node 16.17.0 and it runs OK. 
Looks like I'll need to use https. See this (web site)[https://letsencrypt.org/docs/certificates-for-localhost/]. 
