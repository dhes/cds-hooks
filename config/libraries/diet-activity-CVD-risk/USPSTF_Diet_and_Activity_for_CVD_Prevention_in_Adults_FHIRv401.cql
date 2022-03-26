// Derived from USPSTF Recommendation on Healthful Diet and Physical Activity for Cardiovascular Disease Prevention in
// Adults With Cardiovascular Risk Factors: Behavioral Counseling.  Grade B recommendation. Available at:
// https://www.uspreventiveservicestaskforce.org/Page/Document/UpdateSummaryFinal/healthy-diet-and-physical-activity-counseling-adults-with-high-risk-of-cvd
//
// This version is a FHIR R4 port of USPSTF_Diet_and_Activity_for_CVD_Prevention_in_Adults_FHIRv102 version '1.1.0'. In
// addition to porting the data model, it also leverages new profiles, resulting in the following additional changes
// from the DSTU2 version:
// - Uses FHIR core Blood Pressure profile (which, from a CQL logic perspective, is the same as the corresponding Argonaut profile)
//   - NOTE: For backward compatibility, the CQL logic retains support for standalone Systolic and Diastolic BP observations
//
// NOTE: The R4 port of this artifact has not been piloted in a clinical setting, but has undergone logic testing and review.
library USPSTF_Diet_and_Activity_for_CVD_Prevention_in_Adults_FHIRv401 version '1.0.0'

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
valueset "Hypertension": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1032.9'
valueset "Elevated Blood Pressure Reading SNOMEDCT": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.513'
valueset "Elevated Blood Pressure Reading ICD10CM": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1047.512'
valueset "LDL Test": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.198.11.1029'
valueset "LDL-c": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.215'
valueset "HDL-C Laboratory Test": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.104.12.1012'
valueset "High Density Lipoprotein (HDL) LOINC": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.600.873'
valueset "Waist circumference": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1032.88'
valueset "Triglycerides LOINC": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.600.881'
valueset "Fasting Plasma Glucose": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1032.87'
valueset "Myocardial Infarction": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.403'
valueset "Acute Myocardial Infarction": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.104.12.1001'
valueset "CABG Surgeries": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.666.5.694'
valueset "Coronary Artery Bypass Graft": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.104.11.1004'
valueset "Percutaneous Coronary Intervention ICD10": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.3157.2000.1'
valueset "Percutaneous Coronary Intervention SNOMEDCT": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.3157.2000.2'
valueset "Ischemic Vascular Disease": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.104.12.1003'
valueset "Carotid Intervention": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.117.1.7.1.204'
valueset "Pregnancy": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.526.3.378'
valueset "Pregnancy (New ICD10 codes published in 2018 and 2019)": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1032.80'
valueset "BMI Follow Up Plan ICD10CM": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1195.112'
valueset "Counseling for Nutrition": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.195.11.1004'
valueset "Counseling for Physical Activity": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113883.3.464.1003.118.11.1042'
valueset "Behavioral Counseling for Nutrition and Activity Referral": 'https://cts.nlm.nih.gov/fhir/ValueSet/2.16.840.1.113762.1.4.1032.79'

// Individual codes
code "Pregnancy status": '82810-3' from "LOINC" display 'Pregnancy status'
code "Pregnant": '77386006' from "SNOMED-CT" display 'Patient currently pregnant (finding)'
// Using the blood pressure panel code defined in FHIR Core Vital Signs profiles: <http://hl7.org/fhir/R4/bp.html>
code "Blood pressure panel": '85354-9' from "LOINC" display 'Blood pressure panel with all children optional'
code "Systolic blood pressure": '8480-6' from "LOINC" display 'Systolic blood pressure'
code "Diastolic blood pressure": '8462-4' from "LOINC" display 'Diastolic blood pressure'
// Using the LOINC Code for the ACC/AHA cardiovascular pooled cohort risk calculator
code "CVD 10-year risk": '79423-0' from "LOINC" display 'Cardiovascular disease 10Y risk [Likelihood] ACC-AHA Pooled Cohort by Goff 2013'

context Patient

// Pertinent patient data

// Observations must have one of the following populated, otherwise ObservationLookBack() will filter out:
// effectiveDateTime, effectivePeriod, issued
define MostRecentLDLcTest:
  C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack(
    [Observation: "LDL Test"] union
    [Observation: "LDL-c"], 6 years)))

define MostRecentLDLcTestResult:
  Convert.to_mg_per_dL_for_blood_cholesterol(C3F.QuantityValue(MostRecentLDLcTest))

define MostRecentHDLcTest:
  C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack(
    [Observation: "HDL-C Laboratory Test"] union
    [Observation: "High Density Lipoprotein (HDL) LOINC"], 6 years)))

define MostRecentHDLcTestResult:
  Convert.to_mg_per_dL_for_blood_cholesterol(C3F.QuantityValue(MostRecentHDLcTest))

define MostRecentWaistCircumferenceMeasurement:
  C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack([Observation: "Waist circumference"], 6 years)))

define MostRecentWaistCircumferenceValue:
  C3F.QuantityValue(MostRecentWaistCircumferenceMeasurement)

define MostRecentTriglycerideLab:
  C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack(
    [Observation: "Triglycerides LOINC"], 6 years)))

define MostRecentTriglycerideLabResult:
  Convert.to_mg_per_dL_for_triglyceride(C3F.QuantityValue(MostRecentTriglycerideLab))

define BloodPressurePanelObservations:
  C3F.Verified(C3F.ObservationLookBack([Observation: "Blood pressure panel"], 6 years))

define SystolicObservations:
  C3F.Verified(C3F.ObservationLookBack([Observation: "Systolic blood pressure"], 6 years))

define DiastolicObservations:
  C3F.Verified(C3F.ObservationLookBack([Observation: "Diastolic blood pressure"], 6 years))

// Get blood pressure panels (for which systolic BP is a component value) and systolic observations (for which
// systolic BP is the primary value). The correct value location needs to be extracted based on the Observation
// code.  See MostRecentSystolicBloodPressureValue.
define MostRecentSystolicBloodPressureReading:
  C3F.MostRecent(
    (BloodPressurePanelObservations BP where exists ((BP.component) C where C.code ~ "Systolic blood pressure"))
    union SystolicObservations)

// Get systolic blood pressure value accounting for whether the Observation is a BP observation or
// Systolic BP observation.
define MostRecentSystolicBloodPressureValue:
  if MostRecentSystolicBloodPressureReading.code ~ "Blood pressure panel" then
    singleton from (
      (MostRecentSystolicBloodPressureReading.component) C
      where C.code ~ "Systolic blood pressure"
      return FHIRHelpers.ToQuantity(C.value as FHIR.Quantity)
    )
  else
    C3F.QuantityValue(MostRecentSystolicBloodPressureReading)

// Get blood pressure panels (for which diastolic BP is a component value) and diastolic observations (for which
// diastolic BP is the primary value). The correct value location needs to be extracted based on the Observation
// code.  See MostRecentDiastolicBloodPressureValue.
define MostRecentDiastolicBloodPressureReading:
  C3F.MostRecent(
    (BloodPressurePanelObservations BP where exists ((BP.component) C where C.code ~ "Diastolic blood pressure"))
    union DiastolicObservations)

// Get diastolic blood pressure value accounting for whether the Observation is a BP observation or
// Diastolic BP observation.
define MostRecentDiastolicBloodPressureValue:
  if MostRecentDiastolicBloodPressureReading.code ~ "Blood pressure panel" then
    singleton from (
      (MostRecentDiastolicBloodPressureReading.component) C
      where C.code ~ "Diastolic blood pressure"
      return FHIRHelpers.ToQuantity(C.value as FHIR.Quantity)
    )
  else
    C3F.QuantityValue(MostRecentDiastolicBloodPressureReading)

define MostRecentFastingPlasmaGlucoseTest:
  C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack(
    [Observation: "Fasting Plasma Glucose"], 6 years)))

define MostRecentFastingPlasmaGlucoseValue:
  Convert.to_mg_per_dL_for_blood_glucose(C3F.QuantityValue(MostRecentFastingPlasmaGlucoseTest))

define MostRecentCVDRiskScore:
  C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack(
    [Observation: "CVD 10-year risk"], 6 years)))

define MostRecentCVDRiskScoreValue:
  C3F.QuantityValue(MostRecentCVDRiskScore)

// Inclusions
define Is18YearsOrOlder:
  AgeInYears() >= 18

// Note no lookback
define HasHypertension:
  Exists(C3F.Confirmed(C3F.ActiveOrRecurring([Condition: "Hypertension"])))

// Opinions differ on how to model elevated BP, so look for Condition and Observation representations
define HasElevatedBloodPressure:
  HasElevatedBloodPressureCondition or
  TwoMostRecentBloodPressurePanelObservationsAreElevated

define HasElevatedBloodPressureCondition:
  Exists(C3F.Confirmed(C3F.ActiveOrRecurring(
    [Condition: "Elevated Blood Pressure Reading SNOMEDCT"] union
    [Condition: "Elevated Blood Pressure Reading ICD10CM"])))

// Check if the last two blood pressure readings were interpreted as elevated blood pressure
define TwoMostRecentBloodPressurePanelObservations:
  Take((BloodPressurePanelObservations BP sort by Coalesce(
    (effective as FHIR.dateTime).value,
    (effective as FHIR.instant).value,
    (effective as FHIR.Period)."end".value,
    (effective as FHIR.Period)."start".value,
    issued.value
  ) desc), 2)

define TwoMostRecentBloodPressurePanelObservationsAreElevated:
  Count(
    TwoMostRecentBloodPressurePanelObservations BP where
      BP.interpretation in "Elevated Blood Pressure Reading SNOMEDCT" or
      BP.interpretation in "Elevated Blood Pressure Reading ICD10CM"
  ) = 2

define HighLDLObservation:
  MostRecentLDLcTestResult > 130 'mg/dL'

define LowHDLObservation:
  MostRecentHDLcTestResult < 40 'mg/dL'

define MetabolicSyndromeRiskFactors:
  ({
    {
      Factor: 'Waist circumference (male)',
      Risk: Patient.gender.value = 'male' and MostRecentWaistCircumferenceValue >= 40 '[in_i]'
    },
    {
      Factor: 'Waist circumference (female)',
      Risk: Patient.gender.value = 'female' and MostRecentWaistCircumferenceValue >= 35 '[in_i]'
    },
    {
      Factor: 'Triglyceride lab result',
      Risk: MostRecentTriglycerideLabResult >= 150 'mg/dL'
    },
    {
      Factor: 'HDL-c result (male)',
      Risk: Patient.gender.value = 'male' and MostRecentHDLcTestResult < 40 'mg/dL'
    },
    {
      Factor: 'HDL-c result (female)',
      Risk: Patient.gender.value = 'female' and MostRecentHDLcTestResult < 50 'mg/dL'
    },
    {
      Factor: 'Systolic blood pressure',
      Risk: MostRecentSystolicBloodPressureValue >= 130 'mm[Hg]'
    },
    {
      Factor: 'Diastolic blood pressure',
      Risk: MostRecentDiastolicBloodPressureValue >= 85 'mm[Hg]'
    },
    {
      Factor: 'Fasting plasma glucose',
      Risk: MostRecentFastingPlasmaGlucoseValue >= 100 'mg/dL'
    }
  }) L where L.Risk = true
  return L.Factor


define HasThreeOrMoreMetabolicSyndromeRiskFactors:
  Count(MetabolicSyndromeRiskFactors) >= 3

define CVDRiskScoreAtLeastSevenPointFivePercent:
  MostRecentCVDRiskScoreValue >= 7.5 '%'

define HasRiskFactors:
  HasHypertension or
  HasElevatedBloodPressure or
  LowHDLObservation or
  HighLDLObservation or
  HasThreeOrMoreMetabolicSyndromeRiskFactors or
  CVDRiskScoreAtLeastSevenPointFivePercent

define Included:
  Is18YearsOrOlder and
  HasRiskFactors

// Exclusions

// Note no lookback and no filter on clinicalStatus
define HasCVD:
  Exists(C3F.Confirmed([Condition: "Myocardial Infarction"]))
  or Exists(C3F.Confirmed([Condition: "Acute Myocardial Infarction"]))
  or Exists(C3F.Confirmed([Condition: "Ischemic Vascular Disease"]))

// Note no lookback
define HasHadCVDProcedures:
  Exists(C3F.Completed([Procedure: "CABG Surgeries"]))
  or Exists(C3F.Completed([Procedure: "Coronary Artery Bypass Graft"]))
  or Exists(C3F.Completed([Procedure: "Percutaneous Coronary Intervention ICD10"]))
  or Exists(C3F.Completed([Procedure: "Percutaneous Coronary Intervention SNOMEDCT"]))
  or Exists(C3F.Completed([Procedure: "Carotid Intervention"]))

// Observations must have one of the following populated, otherwise ObservationLookBack() will filter out:
// effectiveDateTime, effectivePeriod, issued
define MostRecentPregnancyObservation:
  C3F.MostRecent(C3F.Verified(C3F.ObservationLookBack([Observation: "Pregnancy status"], 42 weeks)))

define IsPregnant:
  Exists(C3F.Confirmed(C3F.ActiveCondition(
    [Condition: "Pregnancy"] union
    [Condition: "Pregnancy (New ICD10 codes published in 2018 and 2019)"])))
  or C3F.ConceptValue(MostRecentPregnancyObservation) ~ "Pregnant"

// Procedures must have performedDateTime or performedPeriod fields populated, otherwise ProcedureLookBack() will filter out.
define RecentNutritionAndActivityCounselingProcedures:
  C3F.ProcedurePerformance(C3F.ProcedureLookBack(
    [Procedure: "BMI Follow Up Plan ICD10CM"] union
    [Procedure: "Counseling for Nutrition"] union
    [Procedure: "Counseling for Physical Activity"], 12 months))

// Encounters must have period field populated, otherwise EncounterLookBack() will filter out.
define RecentNutritionAndActivityCounselingEncounters:
  C3F.EncounterLookBack(
    [Encounter] E where
      exists(
        E.reasonCode R where
          FHIRHelpers.ToConcept(R) in "BMI Follow Up Plan ICD10CM"
          or FHIRHelpers.ToConcept(R) in "Counseling for Nutrition"
          or FHIRHelpers.ToConcept(R) in "Counseling for Physical Activity"
      )
      and not (E.status.value in {'cancelled', 'entered-in-error', 'unknown'})
    , 12 months)

// ServiceRequest must have authoredOn field populated, otherwise ServiceRequestLookBack() will filter out.
define RecentNutritionAndActivityCounselingProcedureRequests:
  C3F.ServiceRequestActiveOrCompleted(C3F.ServiceRequestLookBack(
    [ServiceRequest: "BMI Follow Up Plan ICD10CM"] union
    [ServiceRequest: "Counseling for Nutrition"] union
    [ServiceRequest: "Counseling for Physical Activity"], 12 months))

// ServiceRequest must have authoredOn field populated, otherwise ServiceRequestLookBack() will filter out.
define RecentNutritionAndActivityCounselingReferralRequests:
  C3F.ServiceRequestActiveOrCompleted(C3F.ServiceRequestLookBack(
    [ServiceRequest: "Behavioral Counseling for Nutrition and Activity Referral"], 12 months))

define HasHadRecentNutritionAndActivityCounseling:
  Exists(RecentNutritionAndActivityCounselingProcedures) or
  Exists(RecentNutritionAndActivityCounselingEncounters) or
  Exists(RecentNutritionAndActivityCounselingProcedureRequests) or
  Exists(RecentNutritionAndActivityCounselingReferralRequests)

define Excluded:
  HasCVD or
  HasHadCVDProcedures or
  IsPregnant or
  HasHadRecentNutritionAndActivityCounseling

define InPopulation:
  Included and not Excluded

define Notification:
  if InPopulation then
'You may be at risk for (in other words, more likely to have) heart disease or a stroke based upon risk factors you may have.

Risk factors include high blood pressure, high LDL cholesterol (the “bad” kind of cholesterol), low HDL cholesterol (the “good” kind), high Triglycerides, high blood sugar, or too much weight around your middle.'
  else
    null

define Recommendation:
  if InPopulation then
'Experts (i.e., [The U.S. Preventive Services Task Force](https://www.uspreventiveservicestaskforce.org/Page/Name/about-the-uspstf)) find that one way to lower the risk of heart disease and stroke is through counseling and coaching programs that help you eat healthy foods and increase your physical activity (exercise and movement). These programs typically involve a trained counselor who can teach you, help you set goals, share ways to eat a healthy diet and increase physical activity and regularly follow up with you.

Contact your doctor to discuss whether coaching and counseling are right for you.

In addition, the experts know that all adults, whether they are at an increased risk for heart disease and stroke or not, can improve their health through healthy eating and being more physically active.

Here are some links to resources to help you get started:

* [Tips for healthy eating from healthfinder.gov](https://healthfinder.gov/HealthTopics/Category/health-conditions-and-diseases/diabetes/eat-healthy)
* [Online cookbook with recipes for heart-healthy, tasty meals](https://healthyeating.nhlbi.nih.gov/pdfs/Dinners_Cookbook_508-compliant.pdf)
* [Ways to get more active!](https://healthfinder.gov/HealthTopics/Category/health-conditions-and-diseases/diabetes/get-active)
* [The U.S. Preventive Services Task Force Recommendation on “Healthful Diet and Physical Activity for Cardiovascular Disease Prevention in Adults With Cardiovascular Risk Factors”](https://www.uspreventiveservicestaskforce.org/Page/Document/UpdateSummaryFinal/healthy-diet-and-physical-activity-counseling-adults-with-high-risk-of-cvd?ds=1&s=Healthful%20Diet)'
  else
    null

// DH I added the combine and deleted redundant INFORMATION: as in 'INFORMATION: No recent waist circumference measurement available.'
define Information:
  Combine(List{
    if (MostRecentHDLcTest is null) then
      '- No recent HDLc lab test available.'
    else null,
    if (MostRecentWaistCircumferenceMeasurement is null) then
      '- No recent waist circumference measurement available.'
    else null,
    if (MostRecentLDLcTest is null) then
      '- No recent LDLc lab test available.'
    else null,
    if (MostRecentDiastolicBloodPressureReading is null) then
      '- No recent diastolic blood pressure reading available.'
    else null,
    if (MostRecentSystolicBloodPressureReading is null) then
      '- No recent systolic blood pressure reading available.'
    else null,
    if (MostRecentFastingPlasmaGlucoseTest is null) then
      '- No recent fasting plasma glucose lab test available.'
    else null,
    if (MostRecentTriglycerideLab is null) then
      '- No recent triglyceride lab test available.'
    else null,
    if (MostRecentCVDRiskScore is null) then
      '- No recent CVD risk score available.'
    else null
  },'\n')