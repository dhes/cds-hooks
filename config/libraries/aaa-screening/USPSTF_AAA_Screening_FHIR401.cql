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

// Individual codes
code "Tobacco smoking status": '72166-2' from "LOINC" display 'Tobacco smoking status'
code "Never smoker": '266919005' from "SNOMED-CT" display 'Never smoked tobacco (finding)'
code "Ultrasound scan of abdominal aorta": '241462009' from  "SNOMED-CT" display 'Ultrasound scan of abdominal aorta (procedure)'

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
    then Patient.gender.value = 'male' 
  else null

// <http://www.hl7.org/fhir/us/core/StructureDefinition-us-core-smokingstatus.html>
define MostRecentValidSmokingStatus:
  C3F.ConceptValue(C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack([Observation: "Tobacco smoking status"], 6 years))))

define TobaccoSmokingStatus:
  [Observation: "Tobacco smoking status"] S
  return S.value as CodeableConcept
// define EverSmoked:
//   if MostRecentValidSmokingStatus is not null  
//     then any ValidSmokingStatus in CurrentTobaccoSmoker
//   else null

define Included:
  Is65Through75YearsOld
  and TobaccoSmokingStatus in CurrentTobaccoSmoker
  and IsMale

// Exclusions

// define HasAAA: 
  // to do

// define HasHadAaaRepair:
  // to do

define AbdominalAortaUltrasound:
  [Procedure: "Ultrasound scan of abdominal aorta"] P
    where P.status.value = 'completed'

define HasHadAbdominalAortaUltrasound:
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

define HasRecentOrCompletedAbdominalAortaUltrasoundServiceRequest:
  Exists(   RecentAbdominalAortaUltrasoundServiceRequest) or
  Exists(CompletedAbdominalAortaUltrasoundServiceRequest)

// Procedures must have performedDateTime or performedPeriod fields populated, otherwise ProcedureLookBack() will filter out.
// define RecentNutritionAndActivityCounselingProcedures:
//   C3F.ProcedurePerformance(C3F.ProcedureLookBack(
//     [Procedure: "BMI Follow Up Plan ICD10CM"] union
//     [Procedure: "Counseling for Nutrition"] union
//     [Procedure: "Counseling for Physical Activity"], 12 months))

define Excluded:
  // HasAAA or // to do
  // HasHadAaaRepair // to do
  HasHadAbdominalAortaUltrasound or 
  HasRecentOrCompletedAbdominalAortaUltrasoundServiceRequest

define InPopulation:
//  Included and not Excluded // to do
  Included and not Excluded

define Notification:
  if InPopulation then
'You need an abdominal aorta Ultrasound.'
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
   (List{ // to do - there's more
     if (MostRecentValidSmokingStatus is null) then 
     'INFORMATION: No smoking status is available.'
     else null
   }) W where W is not null