This is a clone of the official https://github.com/AHRQ-CDS/AHRQ-CDS-Connect-CQL-SERVICES repository. This repository has companions at https://github.com/dhes/ColonoscopyPolyp and https://github.com/dhes/CQL-Testing-Framework. The first, ColonoscopyPolyp, proposes a data model for recording colonoscopy polyp findings as FHIR resources. The second, CQL-Testing-Framework repository, holds test cases for ColonoscopyPolyp. The current repository will have a copy of the CQL from the second ane will eventually have a test CDS hook. 

Speaking about this repository: 

You can read all about the CQL-SERVICES software in the OFFICIAL-README.md. In brief, this repository runs a service that can be loaded by a [CDS Hooks sandbox](https://sandbox.cds-hooks.org/). The 'hooks' reside in the config\hooks directory. I have retained the hooks provided by AHRQ-CDS-- ascvd-risk.json, cond-med-count-r4.json and statin-use.json--and added a few of my own. The CQL for those hooks is in config\libraries. To activate this service you run `yarn start` within a terminal in the root directory of this project. That starts a server at http://localhost:3000/cds-services. The fictional patient data resides in a [Logica Health](https://sandbox.logicahealth.org) sandbox account. Within Logica Health I have registered an app that gives permission to the CDS Hooks sandbox to access the Logica Health data. Logica uses SMART on FHIR for permissioning. I then go to the Logica Health sandbox and start that registered app. This triggers a SMART on FHIR permission screen. After giving permission you are prompted to select a provider "Persona", then a patient. With luck a fresh CDS-Hooks sandbox page starts and the logic runs on the sandbox web page (rather slowly, be patient). 

The current status is that the hooks that I have configured function as expected and return the reminders that I expect them to return. At present these reminders address risk assessment, screening and prevention. The clinical scenario is a primary care office in the United States. 

In progress is a hook that decides timing of repeat colonoscopies. 

We follow convensions of [Boxwala et al](https://academic.oup.com/jamia/article/18/Supplement_1/i132/797073?login=false) in discussing _knowledge levels_ in these three repositories. Figure 1 illustrates these knowledge levels: 

Figure 1. Knowledge Levels


![Knowledge Levels](/images/KnowledgeLevels.png)

ColonoscopyPolyp translates Level 1 (narrative) procedure reports and pathology reports to a Level 3 (Structured) FHIR data model. The 
