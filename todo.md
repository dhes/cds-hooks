restore line in aaa hooks after troubleshooting is done: "conditionExpression": "InPopulation" or some such

- expose is other race warning from cql if race is other than black or asian

- add a third card to ASCVD risk assessment for the case where age cannot be determined. Should askfor age only. The current card asks for all details even though total cholesteral etc is moot if age is out of range. 
- HDL and total cholesterol in statin-use card prefetch only are sigle values but should be valuesets
- try narrowing Observation prefetch by limiting to labs: Observation?category=http://terminology.hl7.org/CodeSystem/observation-category|laboratory and maybe by date e.g. date=gt2015-12-07
- prefetch for statin-use also needs to fetch MedicationStatement and MedicationDispensed

Links versions: 

  local version: 
            "links": [
            {
              "label": "Start questionnaire",
              "url": "http://localhost:8080/launch_public_ehr.html",
              "type": "smart"
            }
          ]

  remote version: 
            "links": [
            {
              "label": "Start questionnaire",
              "url": "https://absi-screening-app.herokuapp.com/launch.html",
              "type": "smart"
            }
          ]
