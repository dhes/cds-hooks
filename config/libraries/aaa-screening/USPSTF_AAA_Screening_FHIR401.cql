// Derived from USPSTF Recommendation on Abdominal Aortic Aneurysm: Screening.  Grade B recommendation. Available at:
// https://www.uspreventiveservicestaskforce.org/uspstf/recommendation/abdominal-aortic-aneurysm-screening
//
// NOTE: This artifact has not been piloted in a clinical setting, nor has it has undergone logic testing.
library USPSTF_Abdominal_Aortic_Aneurysm_Screening_FHIRv401 version '0.0.1'

// Data model
using FHIR version '4.0.1'

// External libraries
include FHIRHelpers version '4.0.1' called FHIRHelpers
include CDS_Connect_Commons_for_FHIRv401 version '1.0.0' called C3F
include CDS_Connect_Conversions version '1.0.2' called Convert

// Code systems
codesystem "LOINC": 'http://loinc.org'
codesystem "SNOMED-CT": 'http://snomed.info/sct'
codesystem "ICD-10-CM": 'http://hl7.org/fhir/sid/icd-10-cm'

// Value sets
// [See value set in VSAC](https://vsac.nlm.nih.gov/valueset/2.16.840.1.113883.3.600.2390/expansion)
valueset CurrentTobaccoSmoker: 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.600.2390'
// [See value set in VSAC](https://vsac.nlm.nih.gov/valueset/2.16.840.1.113762.1.4.1047.17/expansion)
valueset "Has AAA": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.17'

// Individual codes
code "Tobacco smoking status": '72166-2' from "LOINC" display 'Tobacco smoking status'
code "Smoking status unknown": '266927001' from "SNOMED-CT" display 'Tobacco smoking consumption unknown (finding)'
code "Never smoker": '266919005' from "SNOMED-CT" display 'Never smoked tobacco (finding)'
code "Former smoker": '8517006' from "SNOMED-CT" display 'Ex-smoker (finding)'
code "Ultrasound scan of abdominal aorta": '241462009' from  "SNOMED-CT" display 'Ultrasound scan of abdominal aorta (procedure)'
code "Had AAA repair": '429205001' from "SNOMED-CT" display 'History of repair of aneurysm of abdominal aorta (situation)'

// notes:
// Aorta/Iliac ultrasound (limited) CPT 93979
// SNOMEDCT 241462009 | Ultrasound scan of abdominal aorta (procedure) 
// LOINC 79374-5 US Abdominal Aorta for screening

context Patient

// Pertinent patient data

// This Age definition is just so
// ...coders can see the age as they troubleshoot. 
// ...You safely delete it. 
define Age: 
  AgeInYears()

define Is65Through75YearsOld:
  AgeInYears() >= 65 and AgeInYears() <76

define IsMale: 
  if Patient.gender.value is not null 
    then Patient.gender.value = 'male' // or Patient.gender ~ 'male' ?
  else null

// <http://www.hl7.org/fhir/us/core/StructureDefinition-us-core-smokingstatus.html>
// take most recent smoking status observation as the authoritative one
define MostRecentValidSmokingStatus:
  C3F.ConceptValue(C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack([Observation: "Tobacco smoking status"], 6 years))))

// for troubleshooting
define TobaccoSmokingStatus:
  [Observation: "Tobacco smoking status"] S
  return S.value as CodeableConcept

define FormerSmoker:
  if MostRecentValidSmokingStatus is not null
    then MostRecentValidSmokingStatus = "Former smoker" // or ~ "Former smoker"?
  else null

define TobaccoHistoryNeeded:
  MostRecentValidSmokingStatus is null or
  MostRecentValidSmokingStatus ~ "Smoking status unknown"

define InPopulationAndTobaccoHistoryNeeded:
  InPopulation and TobaccoHistoryNeeded

define IsEverSmoker:
  if MostRecentValidSmokingStatus is not null  
    then 
      MostRecentValidSmokingStatus in CurrentTobaccoSmoker
      or MostRecentValidSmokingStatus = "Former smoker" // see above, or ~ "Former smoker"
  else null

// We assume the most recent history is the most accurate

define Included:
  IsMale
  and Is65Through75YearsOld
  and IsEverSmoker

// Exclusions

define HasAAA: 
  Exists([Condition: "Has AAA"])

define HadAaaRepair:
  Exists([Condition: "Had AAA repair"])

define AbdominalAortaUltrasound:
  [Procedure: "Ultrasound scan of abdominal aorta"] P
    where P.status.value = 'completed' // ??? P.status ~ 'completed'

define HadAbdominalAortaUltrasound:
  Exists(AbdominalAortaUltrasound)

define AbdominalAortaUltrasoundServiceRequest:
  [ServiceRequest: "Ultrasound scan of abdominal aorta"]

define RecentAbdominalAortaUltrasoundServiceRequest:
  C3F.ServiceRequestLookBack(
    [ServiceRequest: "Ultrasound scan of abdominal aorta"] R
      where R.status.value = 'active', 12 months)

define CompletedAbdominalAortaUltrasoundServiceRequest:
  [ServiceRequest: "Ultrasound scan of abdominal aorta"] R
          where R.status.value = 'completed'

define HasRecentOrCompletedbdomenAortaUltrasoundServiceRequest:
  Exists(   RecentAbdominalAortaUltrasoundServiceRequest) or
  Exists(CompletedAbdominalAortaUltrasoundServiceRequest)

// Procedures must have performedDateTime or performedPeriod fields populated, otherwise ProcedureLookBack() will filter out.
// define RecentNutritionAndActivityCounselingProcedures:
//   C3F.ProcedurePerformance(C3F.ProcedureLookBack(
//     [Procedure: "BMI Follow Up Plan ICD10CM"] union
//     [Procedure: "Counseling for Nutrition"] union
//     [Procedure: "Counseling for Physical Activity"], 12 months))

define Excluded:
  HasAAA or 
  HadAaaRepair or
  HadAbdominalAortaUltrasound or 
  HasRecentOrCompletedbdomenAortaUltrasoundServiceRequest

define InPopulation:
//  Included and not Excluded // to do
  Included and not Excluded

define Notification:
  if InPopulation then
'You should have an abdominal aorta ultrasound.'
  else
    null

define Recommendation:
  if InPopulation then
'Experts (i.e., [The U.S. Preventive Services Task Force](https://www.uspreventiveservicestaskforce.org/Page/Name/about-the-uspstf)) find that men your age that ever smoked should have an ultrasound performed on their aorta to make sure there is not aneurysm.

Here are some links to resources to help you get started:

* [The U.S. Preventive Services Task Force Recommendation on “Abdominal Aortic Aneurysm: Screening”](ttps://www.uspreventiveservicestaskforce.org/uspstf/recommendation/abdominal-aortic-aneurysm-screening)'
  else
    null

 define Information: // to do
   //(List{ // to do - there may be more
     if TobaccoHistoryNeeded  
     then 
      'INFORMATION: Please record a tobacco history. Has this patient ever smoked?'
     else null
   //}) W where W is not null