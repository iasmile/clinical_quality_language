library ANCContactDataElements

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'
include FHIRCommon called FC

include WHOCommon called WC
include ANCCommon called AC
include ANCConcepts called Cx

parameter encounter String

context Patient



define "Contact date":
  WC.Only(
  [Encounter] E
    where E.id = Last(Split(encounter, '/'))
  ).period.start




define "Reason for coming to facility":
  WC.Only(
  [Encounter: Cx."Reason for coming to facility"] E
    where E.id = Last(Split(encounter, '/'))
  ).reasonCode




define "ANC contact number":
  AC.Extension(WC.Only(
  [Encounter] E
    where E.id = Last(Split(encounter, '/'))
  ), 'contactNumber').value as integer




define "Unique identification":
  singleton from ([Patient] P return WC.Official(P.identifier).value)




define "First name":
  singleton from ([Patient] P return First(WC.Official(P.name).given))




define "Last name":
  singleton from ([Patient] P return WC.Official(P.name).family)




define "Date of birth":
  singleton from ([Patient] P return P.birthDate)




define "Address":
  singleton from ([Patient] P return WC.Official(P.address).text)




define "Mobile phone number":
  singleton from ([Patient] P return WC.Mobile(P.telecom).value)




define "Alternative contact's name":
  WC.Official(First([Patient] P return P.contact).name).text




define "Alternative contact's phone number":
  First(First([Patient] P return P.contact).telecom).value




define "Woman wants to receive reminders during pregnancy":
  singleton from ([Patient] P return AC.Extension(P, 'reminder').value as boolean)




define "Highest level of education achieved":
  singleton from (
  [Patient] P
    return AC.Extension(P, 'eductaionLevel').value as FHIR.CodeableConcept
  )




define "Occupation":
  singleton from ([Patient] P
    return AC.Extension(P, 'occupation').value as FHIR.CodeableConcept
  )




define "Co-habitants":
  [Observation: Cx."Co-habitants"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Pregnancy confirmed":
  WC.Only(
  [Observation: Cx."Pregnancy confirmed"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Danger signs":
  [Observation: Cx."Danger signs"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Specific health concern(s)":
  [Observation: Cx."Specific health concern(s)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Tetanus toxoid-containing vaccine (TTCV) immunization history":
  WC.MostRecent(
  [Observation: Cx."Tetanus toxoid-containing vaccine (TTCV) immunization history"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Flu immunization history":
  WC.MostRecent(
  [Observation: Cx."Flu immunization history"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Current medications":
  [Observation: Cx."Current medications"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Daily caffeine intake":
  [Observation: Cx."Daily caffeine intake"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Last menstrual period (LMP) date":
  WC.MostRecent(
  [Observation: Cx."Last menstrual period (LMP) date"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.dateTime




define "Clinical enquiry for alcohol and other substance use done":
  WC.Only(
  [Observation: Cx."Clinical enquiry for alcohol and other substance use done"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Current alcohol and/or other substance use":
  [Observation: Cx."Current alcohol and/or other substance use"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Ultrasound done":
  WC.MostRecent(
  [Observation: Cx."Ultrasound done"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Tobacco use":
  WC.Only(
  [Observation: Cx."Tobacco use"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Recently quit tobacco products":
  WC.Only(
  [Observation: Cx."Recently quit tobacco products"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Exposure to second-hand smoke":
  WC.Only(
  [Observation: Cx."Exposure to second-hand smoke"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Partner HIV status (reported)":
  WC.Only(
  [Observation: Cx."Partner HIV status (reported)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Contraceptive use of male condoms":
  WC.Only(
  [Observation: Cx."Contraceptive use of male condoms"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Contraceptive use of female condoms":
  WC.Only(
  [Observation: Cx."Contraceptive use of female condoms"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Gestational age":
  WC.MostRecent(
  [Observation: Cx."Gestational age"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Source of gestational age":
  WC.MostRecent(
  [Observation: Cx."Source of gestational age"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Expected date of delivery (EDD)":
  WC.Only(
  [Observation: Cx."Expected date of delivery (EDD)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.dateTime




define "Number of pregnancies (gravida)":
  WC.Only(
  [Observation: Cx."Number of pregnancies (gravida)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.integer




define "Number of miscarriages and/or abortions":
  WC.Only(
  [Observation: Cx."Number of miscarriages and/or abortions"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.integer




define "Number of live births":
  WC.Only(
  [Observation: Cx."Number of live births"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.integer




define "Whether last live birth was preterm":
  WC.MostRecent(
  [Observation: Cx."Whether last live birth was preterm"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Number of stillbirths":
  WC.MostRecent(
  [Observation: Cx."Number of stillbirths"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.integer




define "Parity":
  WC.MostRecent(
  [Observation: Cx."Parity"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.integer




define "Number of caesarian sections":
  WC.MostRecent(
  [Observation: Cx."Number of caesarian sections"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.integer




define "Past pregnancy complications":
  [Observation: Cx."Past pregnancy complications"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Substance use during past pregnancy specification":
  [Observation: Cx."Substance use during past pregnancy specification"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Allergies":
  [Observation: Cx."Allergies"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Past surgeries":
  [Observation: Cx."Past surgeries"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Existing chronic health conditions":
  [Observation: Cx."Existing chronic health conditions"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "HIV diagnosis date":
  [Observation: Cx."HIV diagnosis date"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Ultrasound date":
  WC.MostRecent(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).performed as FHIR.dateTime




define "Ultrasound scan conducted":
  WC.Only(
  [Procedure: Cx."Ultrasound scan conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Medication follow-up":
  [Observation: Cx."Medication follow-up"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Persistent physiological symptoms":
  [Observation: Cx."Persistent physiological symptoms"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Current physiological symptoms":
  [Observation: Cx."Current physiological symptoms"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Presenting signs and symptoms that trigger suspicion of IPV and clinical inquiry":
  [Observation: Cx."Presenting signs and symptoms that trigger suspicion of IPV and clinical inquiry"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Woman discloses or is suspected to be subjected to intimate partner violence":
  WC.Only(
  [Observation: Cx."Woman discloses or is suspected to be subjected to intimate partner violence"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Fetal movement":
  WC.Only(
  [Observation: Cx."Fetal movement"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Persistent behaviours":
  [Observation: Cx."Persistent behaviours"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Has the woman  been subjected to intimate partner violence":
  WC.Only(
  [Observation: Cx."Has the woman  been subjected to intimate partner violence"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Height":
  WC.Only(
  [Observation: Cx."Height"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Expected weight gain":
  WC.Only(
  [Observation: Cx."Expected weight gain"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Oedema severity":
  WC.Only(
  [Observation: Cx."Oedema severity"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Symphysis-fundal height (SFH)":
  WC.Only(
  [Observation: Cx."Symphysis-fundal height (SFH)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Fetal heartbeat present":
  WC.Only(
  [Observation: Cx."Fetal heartbeat present"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Fetal heart rate":
  WC.Earliest(
  [Observation: Cx."Fetal heart rate"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Second fetal heart rate":
  WC.MostRecent(
  [Observation: Cx."Second fetal heart rate"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Number of fetuses":
  WC.Only(
  [Observation: Cx."Number of fetuses"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Number of fetuses unknown":
  WC.Only(
  [Observation: Cx."Number of fetuses unknown"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Fetal presentation":
  WC.Only(
  [Observation: Cx."Fetal presentation"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Presenting signs/conditions for IPV":
  [Observation: Cx."Presenting signs/conditions for IPV"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Clinical enquiry for IPV":
  WC.Only(
  [Observation: Cx."Clinical enquiry for IPV"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Reason clinical enquiry not done":
  WC.Only(
  [Observation: Cx."Reason clinical enquiry not done"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Types of IPV":
  [Observation: Cx."Types of IPV"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Average weight gain per week":
  WC.Only(
  [Observation: Cx."Average weight gain per week"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Total weight gain (kg)":
  WC.Only(
  [Observation: Cx."Total weight gain (kg)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Systolic blood pressure":
  WC.Earliest(
  [Observation: Cx."Systolic blood pressure"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Diastolic blood pressure":
  WC.Earliest(
  [Observation: Cx."Diastolic blood pressure"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Pre-gestational weight":
  WC.Only(
  [Observation: Cx."Pre-gestational weight"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Repeat systolic blood pressure":
  WC.MostRecent(
  [Observation: Cx."Repeat systolic blood pressure"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Repeat diastolic blood pressure":
  WC.MostRecent(
  [Observation: Cx."Repeat diastolic blood pressure"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Blood pressure cannot be taken":
  WC.Only(
  [Observation: Cx."Blood pressure cannot be taken"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Reason blood pressure cannot be taken":
  WC.Only(
  [Observation: Cx."Reason blood pressure cannot be taken"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Symptoms of severe pre-eclampsia":
  [Observation: Cx."Symptoms of severe pre-eclampsia"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Current  weight":
  WC.Only(
  [Observation: Cx."Current  weight"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Body temperature":
  WC.Earliest(
  [Observation: Cx."Body temperature"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Second body temperature":
  WC.MostRecent(
  [Observation: Cx."Second body temperature"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Pulse rate":
  WC.Earliest(
  [Observation: Cx."Pulse rate"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Second pulse rate":
  WC.MostRecent(
  [Observation: Cx."Second pulse rate"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Pallor present":
  WC.Only(
  [Observation: Cx."Pallor present"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Respiratory exam result":
  WC.Only(
  [Observation: Cx."Respiratory exam result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "BMI":
  WC.Only(
  [Observation: Cx."BMI"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Oximetry":
  WC.Only(
  [Observation: Cx."Respiratory exam result - Oximetry"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Weight category":
  WC.Only(
  [Observation: Cx."Weight category"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Cardiac exam result":
  WC.Only(
  [Observation: Cx."Cardiac exam result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Breast exam result":
  WC.Only(
  [Observation: Cx."Breast exam result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Abdominal exam result":
  WC.Only(
  [Observation: Cx."Abdominal exam result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Pelvic exam result (visual)":
  WC.Only(
  [Observation: Cx."Pelvic exam result (visual)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Cervical exam conducted":
  WC.Only(
  [Observation: Cx."Cervical exam conducted"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Cervical dilation":
  WC.Only(
  [Observation: Cx."Cervical dilation"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Oedema present":
  WC.Only(
  [Observation: Cx."Oedema present"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Oedema type":
  [Observation: Cx."Oedema type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Ultrasound required":
  WC.Only(
  [Observation: Cx."Ultrasound required"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Reason syphilis test not done":
  [Observation: Cx."Reason syphilis test not done"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Syphilis test result":
  WC.Only(
  [Observation: Cx."Syphilis test result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Syphilis diagnosis":
  WC.Only(
  [Observation: Cx."Syphilis diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Urine test required":
  WC.Only(
  [Observation: Cx."Urine test required"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Urine test ordered":
  WC.Only(
  [ServiceRequest: Cx."Urine test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Urine test type":
  [Observation: Cx."Urine test type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return O.value as FHIR.CodeableConcept




define "Reason urine test not done":
  [Procedure: Cx."Reason urine test not done"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Midstream urine culture (recommended)":
  WC.Only(
  [Observation: Cx."Midstream urine culture (recommended)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Midstream urine Gram-staining":
  WC.Only(
  [Observation: Cx."Midstream urine Gram-staining"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Placenta location":
  WC.Only(
  [Observation: Cx."Placenta location"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Urine dipstick result - nitrites":
  WC.Only(
  [Observation: Cx."Urine dipstick result - nitrites"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Urine dipstick result - leukocytes":
  WC.Only(
  [Observation: Cx."Urine dipstick result - leukocytes"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Urine dipstick result - protein":
  WC.Only(
  [Observation: Cx."Urine dipstick result - protein"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Urine dipstick result - glucose":
  WC.Only(
  [Observation: Cx."Urine dipstick result - glucose"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Asymptomatic bacteriuria (ASB) diagnosis":
  WC.Only(
  [Observation: Cx."Asymptomatic bacteriuria (ASB) diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Blood glucose test ordered":
  WC.Only(
  [ServiceRequest: Cx."Blood glucose test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Blood glucose test type":
  WC.Only(
  [Observation: Cx."Blood glucose test type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Fasting plasma glucose":
  WC.Only(
  [Observation: Cx."Fasting plasma glucose"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "75 g oral glucose tolerance test (OGTT) - fasting glucose":
  WC.Only(
  [Observation: Cx."75 g oral glucose tolerance test (OGTT) - fasting glucose"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "75 g oral glucose tolerance test (OGTT) - 1 hour":
  WC.Only(
  [Observation: Cx."75 g oral glucose tolerance test (OGTT) - 1 hour"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "75 g oral glucose tolerance test (OGTT) - 2 hours":
  WC.Only(
  [Observation: Cx."75 g oral glucose tolerance test (OGTT) - 2 hours"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Random plasma glucose":
  WC.Only(
  [Observation: Cx."Random plasma glucose"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Blood glucose test result":
  WC.Only(
  [Observation: Cx."Blood glucose test result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Gestational diabetes mellitus (GDM) diagnosis":
  WC.Only(
  [Observation: Cx."Gestational diabetes mellitus (GDM) diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Diabetes mellitus (DM) during pregnancy diagnosis":
  WC.Only(
  [Observation: Cx."Diabetes mellitus (DM) during pregnancy diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Blood haemoglobin test ordered":
  WC.Only(
  [ServiceRequest: Cx."Blood haemoglobin test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Blood haemoglobin test type":
  WC.Only(
  [Observation: Cx."Blood haemoglobin test type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Reason blood haemoglobin test not done":
  [Procedure: Cx."Reason blood haemoglobin test not done"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Blood haemoglobin test result":
  WC.Only(
  [Observation: Cx."Blood haemoglobin test result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Anaemia diagnosis":
  WC.Only(
  [Observation: Cx."Anaemia diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Hematocrit (Ht)":
  WC.Only(
  [Observation: Cx."Hematocrit (Ht)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "White blood cell (WBC) count":
  WC.Only(
  [Observation: Cx."White blood cell (WBC) count"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "Platelet count":
  WC.Only(
  [Observation: Cx."Platelet count"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.Quantity




define "TB screening recommended":
  WC.Only(
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "TB screening ordered":
  WC.Only(
  [ServiceRequest: Cx."TB screening ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason TB screening not done":
  [Procedure: Cx."Reason TB screening not done"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Ultrasound scan ordered":
  WC.Only(
  [ServiceRequest: Cx."Ultrasound scan ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "TB screening result":
  WC.Only(
  [Observation: Cx."TB screening result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Blood type test ordered":
  WC.Only(
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Other test(s) result(s)":
  WC.Only(
  [Observation: Cx."Other test(s) result(s)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Blood type":
  WC.Only(
  [Observation: Cx."Blood type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Rh factor":
  WC.Only(
  [Observation: Cx."Rh factor"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "HIV test required":
  WC.Only(
  [Observation: Cx."HIV test required"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "HIV test ordered":
  WC.Only(
  [ServiceRequest: Cx."HIV test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason HIV test not done":
  [Procedure: Cx."Reason HIV test not done"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "HIV test result":
  WC.Only(
  [Observation: Cx."HIV test result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "HIV status":
  WC.Only(
  [Observation: Cx."HIV status"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Partner HIV test result":
  WC.Only(
  [Observation: Cx."Partner HIV test result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Partner HIV test ordered":
  WC.Only(
  [ServiceRequest: Cx."Partner HIV test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason ultrasound scan not done":
  WC.Only(
  [Procedure: Cx."Reason ultrasound scan not done"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Partner HIV status (confirmed)":
  WC.Only(
  [Observation: Cx."Partner HIV status (confirmed)"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "High risk for HIV":
  WC.Only(
  [Observation: Cx."High risk for HIV"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Hepatitis B test required":
  WC.Only(
  [Observation: Cx."Hepatitis B test required"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Hepatitis B test ordered":
  WC.Only(
  [ServiceRequest: Cx."Hepatitis B test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Hepatitis B test type":
  WC.Only(
  [Observation: Cx."Hepatitis B test type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Hepatitis B test result":
  [Procedure: Cx."Hepatitis B test result"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Hepatitis B diagnosis":
  WC.Only(
  [Observation: Cx."Hepatitis B diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Hepatitis C test required":
  WC.Only(
  [Observation: Cx."Hepatitis C test required"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Hepatitis C test ordered":
  [ServiceRequest: Cx."Hepatitis C test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Hepatitis C test type":
  WC.Only(
  [Observation: Cx."Hepatitis C test type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Reason Hepatitis C test not done":
  [Procedure: Cx."Reason Hepatitis C test not done"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Hepatitis C test result":
  WC.Only(
  [Observation: Cx."Hepatitis C test result"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Amniotic fluid level":
  WC.Only(
  [Observation: Cx."Amniotic fluid level"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Hepatitis C diagnosis":
  WC.Only(
  [Observation: Cx."Hepatitis C diagnosis"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Syphilis test ordered":
  WC.Only(
  [ServiceRequest: Cx."Syphilis test ordered"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Syphilis test type":
  WC.Only(
  [Observation: Cx."Syphilis test type"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Blood glucose test date":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).performed as FHIR.dateTime




define "Blood haemoglobin test conducted":
  WC.Only(
  [Procedure: Cx."Blood haemoglobin test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Blood haemoglobin test date":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).performed as FHIR.dateTime




define "Blood type test conducted":
  WC.Only(
  [Procedure: Cx."Blood type test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Blood type test date":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).performed as FHIR.dateTime




define "Hepatitis B test conducted":
  WC.Only(
  [Procedure: Cx."Hepatitis B test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Hepatitis B test date":
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Hepatitis C test conducted":
  WC.Only(
  [Procedure: Cx."Hepatitis C test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Hepatitis C test date":
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "HIV test conducted":
  WC.Only(
  [Procedure: Cx."HIV test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "HIV test date":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).performed as FHIR.dateTime




define "Other tests conducted":
  WC.Only(
  [Procedure: Cx."Other tests conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Other test(s) name":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code.text




define "Other test(s) date":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).performed as FHIR.dateTime




define "Partner HIV test conducted":
  WC.Only(
  [Procedure: Cx."Partner HIV test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Partner HIV test date":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).performed as FHIR.dateTime




define "Syphilis test conducted":
  WC.Only(
  [Procedure: Cx."Syphilis test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Syphilis test date":
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "TB screening conducted":
  WC.Only(
  [Procedure: Cx."TB screening conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "TB screening date":
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Urine test conducted":
  WC.Only(
  [Procedure: Cx."Urine test conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Urine test date":
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Counselling conducted on caffeine reduction":
  WC.Only(
  [Procedure: Cx."Counselling on Caffeine Reduction"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on second-hand smoke was not conducted":
  [Procedure: Cx."Counselling on Second-Hand Smoke"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Counselling conducted on condom use":
  WC.Only(
  [Procedure: Cx."Counselling on Condom Use"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on condom use was not conducted":
  [Procedure: Cx."Counselling on Condom Use"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Counselling conducted on alcohol / substance use":
  WC.Only(
  [Procedure: Cx."Counselling on Alcohol Substance Abuse"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on alcohol / substance use was not conducted":
  [Procedure: Cx."Counselling on Alcohol Substance Abuse"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Reason counselling on caffeine reduction was not done":
  [Procedure: Cx."Counselling on Caffeine Reduction"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Counselling conducted on tobacco cessation":
  WC.Only(
  [Procedure: Cx."Counselling on Tobacco Cessation"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on tobacco cessation was not conducted":
  [Procedure: Cx."Counselling on Tobacco Cessation"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Counselling conducted on second-hand smoke":
  WC.Only(
  [Procedure: Cx."Counselling on Second-Hand Smoke"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on non-pharma measures to relieve nausea and vomiting":
  WC.Only(
  [Procedure: Cx."Counselling on Non-Pharma Measures to Relieve Nausea and Vomiting"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on non-pharma measures to relieve nausea and vomiting was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Non-Pharma Measures to Relieve Nausea and Vomiting"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on pharmacological treatments for nausea and vomiting":
  WC.Only(
  [Procedure: Cx."Counselling on Pharmacological Measures to Relieve Nausea and Vomiting"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on pharmacological treatments for nausea and vomiting was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Pharmacological Measures to Relieve Nausea and Vomiting"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on diet and lifestyle changes to prevent and relieve heartburn":
  WC.Only(
  [Procedure: Cx."Counselling on Diet and Lifestyle Changes to Prevent and Relieve Heartburn"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on diet and lifestyle changes to prevent and relieve heartburn was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Diet and Lifestyle Changes to Prevent and Relieve Heartburn"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on antacid preparations to relieve heartburn":
  WC.Only(
  [Procedure: Cx."Counselling on Antacid Preparations to Relieve Heartburn"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on antacid preparations to relieve heartburn was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Antacid Preparations to Relieve Heartburn"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling on non-pharmacological treatment for the relief of leg cramps":
  WC.Only(
  [Procedure: Cx."Counselling on Non-Pharmacological Treatment for Relief of Leg Cramps"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on non-pharmacological treatment for the relief of leg cramps was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Non-Pharmacological Treatment for Relief of Leg Cramps"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on use of magnesium and calcium to relieve leg cramps":
  WC.Only(
  [Procedure: Cx."Counselling on Use of Magnesium-and Calcium to Relieve Leg Cramps"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on use of magnesium and calcium to relieve leg cramps was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Use of Magnesium-and Calcium to Relieve Leg Cramps"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on dietary modifications to relieve constipation":
  WC.Only(
  [Procedure: Cx."Counselling on Dietary Modifications to Relieve Constipation"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on dietary modifications to relieve constipation was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Dietary Modifications to Relieve Constipation"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on use of wheat bran or other fibre supplements to relieve constipation":
  WC.Only(
  [Procedure: Cx."Counselling on Use of Wheat Bran or Other Fibre Supplements to Relieve Constipation"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on use of wheat bran or other fibre supplements to relieve constipation was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Use of Wheat Bran or Other Fibre Supplements to Relieve Constipation"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on regular exercise, physiotherapy, support belts and acupuncture to relieve low back and pelvic pain":
  WC.Only(
  [Procedure: Cx."Counselling on Regular Exercise Physiotherapy Support Belts and Acupuncture to Relieve Low Back and Pelvic Pain"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on regular exercise, physiotherapy, support belts and acupuncture to relieve low back and pelvic pain was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Regular Exercise Physiotherapy Support Belts and Acupuncture to Relieve Low Back and Pelvic Pain"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on non-pharmacological options for varicose veins and oedema":
  WC.Only(
  [Procedure: Cx."Counselling on Non-Pharmacological Options for Varicose Veins and Oedema"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on non-pharmacological options for varicose veins and oedema was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling on Non-Pharmacological Options for Varicose Veins and Oedema"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on healthy eating and keeping physically active":
  WC.Only(
  [Procedure: Cx."Counselling on Healthy Eating and Keeping Physically Active"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on healthy eating and keeping physically active was not conducted":
  [Procedure: Cx."Counselling on Healthy Eating and Keeping Physically Active"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Counselling conducted on increasing daily energy and protein intake":
  WC.Only(
  [Procedure: Cx."Counselling on Increasing Daily Energy Protein Intake"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on increasing daily energy and protein intake was not conducted":
  [Procedure: Cx."Counselling on Increasing Daily Energy Protein Intake"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Counselling conducted on balanced energy and protein dietary supplementation":
  WC.Only(
  [Procedure: Cx."Counselling on Balanced Energy and Protein Dietary Supplementation"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason counselling on balanced energy and protein dietary supplementation was not conducted":
  [Procedure: Cx."Counselling on Balanced Energy and Protein Dietary Supplementation"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return PND.code




define "Hypertension":
  WC.Only(
  [Condition: Cx."Hypertension"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
      and Last(Split(C.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Severe hypertension":
  WC.Only(
  [Condition: Cx."Severe hypertension"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
      and Last(Split(C.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Pre-eclampsia":
  WC.Only(
  [Condition: Cx."Pre-eclampsia"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
      and Last(Split(C.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Severe pre-eclampsia":
  WC.Only(
  [Condition: Cx."Severe pre-eclampsia"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
      and Last(Split(C.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on hypertension":
  WC.Only(
  [Procedure: Cx."Counselling conducted on hypertension"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on HIV positive":
  WC.Only(
  [Procedure: Cx."Counselling conducted on HIV positive"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on hepatitis B positive":
  WC.Only(
  [Procedure: Cx."Counselling conducted on hepatitis B positive"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on hepatitis C positive":
  WC.Only(
  [Procedure: Cx."Counselling conducted on hepatitis C positive"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Syphilis counselling and treatment":
  WC.Only(
  [Procedure: Cx."Syphilis counselling and treatment"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Syphilis counselling, treatment and further testing":
  WC.Only(
  [Procedure: Cx."Syphilis counselling, treatment and further testing"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Seven-day antibiotic regimen for asymptomatic bacteriuria (ASB) provided":
  WC.Only(
  [Procedure: Cx."Seven-day antibiotic regimen for asymptomatic bacteriuria (ASB) provided"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason seven-day antibiotic regimen for asymptomatic bacteriuria (ASB) not provided":
  WC.Only(
  [Procedure: Cx."Reason seven-day antibiotic regimen for asymptomatic bacteriuria (ASB) not provided"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on TB screening positive":
  WC.Only(
  [Procedure: Cx."Counselling conducted on TB screening positive"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on gestational diabetes mellitus (GDM)":
  WC.Only(
  [Procedure: Cx."Counselling conducted on gestational diabetes mellitus (GDM)"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on diabetes mellitus (DM)":
  WC.Only(
  [Procedure: Cx."Counselling conducted on diabetes mellitus (DM)"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on anaemia":
  WC.Only(
  [Procedure] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Vitamin A supplementation not provided":
  [MedicationRequest: Cx."Vitamin A supplementation not provided"] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and MR.doNotPerform is true
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return MR.medication as FHIR.CodeableConcept




define "Amount of daily calcium supplements provided":
  singleton from (WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.doseAndRate.dose) as FHIR.SimpleQuantity




define "Reason calcium not prescribed":
  WC.Only(
  [MedicationRequest: Cx."Reason calcium not prescribed"] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and MR.doNotPerform is true
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).medication as FHIR.CodeableConcept




define "Amount of daily dose of folic acid prescribed":
  singleton from (WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.doseAndRate.dose) as FHIR.SimpleQuantity




define "Reason iron and folic acid not prescribed":
  WC.Only(
  [MedicationRequest: Cx."Reason iron and folic acid not prescribed"] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and MR.doNotPerform is true
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).medication as FHIR.CodeableConcept




define "Amount of iron prescribed":
  singleton from (WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.doseAndRate.dose) as FHIR.SimpleQuantity




define "Type of iron supplement dosage provided":
  WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.timing.repeat.periodUnit




define "Amount of vitamin A supplementation provided":
  singleton from (WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.doseAndRate.dose) as FHIR.SimpleQuantity




define "Type of vitamin A supplement dosage provided":
  WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.timing.repeat.periodUnit




define "Risk of pre-eclampsia":
  WC.Only(
  [Condition: Cx."Risk of pre-eclampsia"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
      and Last(Split(C.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Pre-eclampsia risk counselling provided":
  WC.Only(
  [Procedure: Cx."Pre-eclampsia risk counselling provided"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Amount of daily aspirin prescribed until delivery":
  singleton from (WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.doseAndRate.dose) as FHIR.SimpleQuantity




define "Reason aspirin not prescribed":
  WC.Only(
  [MedicationRequest: Cx."Reason aspirin not prescribed"] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and MR.doNotPerform is true
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).medication as FHIR.CodeableConcept




define "Risk of gestational diabetes mellitus (GDM)":
  WC.Only(
  [Condition: Cx."Risk of gestational diabetes mellitus (GDM)"] C
    where C.clinicalStatus in FC."Active Condition"
      and C.verificationStatus ~ FC."confirmed"
      and Last(Split(C.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Gestational diabetes mellitus (GDM) risk counselling conducted":
  WC.Only(
  [Procedure: Cx."Gestational diabetes mellitus (GDM) risk counselling conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on HIV risk":
  WC.Only(
  [Procedure: Cx."Counselling conducted on HIV risk"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "PrEP for HIV prevention provided":
  WC.Only(
  [Procedure: Cx."PrEP for HIV prevention provided"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason PrEP for HIV prevention was not provided":
  [MedicationRequest: Cx."Reason PrEP for HIV prevention was not provided"] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and MR.doNotPerform is true
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return MR.medication as FHIR.CodeableConcept




define "Amount of oral PrEP provided":
  singleton from (WC.Only(
  [MedicationRequest] MR
    where MR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(MR.doNotPerform, false) is false
      and Last(Split(MR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).dosageInstruction.doseAndRate.dose) as FHIR.SimpleQuantity




define "Counselling conducted on seeking care when danger signs occur":
  WC.Only(
  [Procedure: Cx."Counselling conducted on seeking care when danger signs occur"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counsel to immediately go to the hospital if severe danger signs are present":
  WC.Only(
  [Procedure: Cx."Counsel to immediately go to the hospital if severe danger signs are present"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling on ANC contact schedule conducted":
  WC.Only(
  [Procedure: Cx."Counselling on ANC contact schedule conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on birth preparedness and complications readiness":
  WC.Only(
  [Procedure: Cx."Counselling conducted on birth preparedness and complications readiness"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Planned birth place":
  WC.Only(
  [Observation: Cx."Planned birth place"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Counselling conducted on Rh factor negative":
  WC.Only(
  [Procedure: Cx."Counselling conducted on Rh factor negative"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on intrapartum antibiotic to prevent early neonatal Group B Streptococcus (GBS) infection":
  WC.Only(
  [Procedure: Cx."Counselling conducted on intrapartum antibiotic to prevent early neonatal Group B Streptococcus (GBS) infection"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling on postpartum family planning conducted":
  WC.Only(
  [Procedure: Cx."Counselling on postpartum family planning conducted"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Family planning method selected":
  WC.Only(
  [Observation: Cx."Family planning method selected"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Counselling conducted on breastfeeding":
  WC.Only(
  [Procedure: Cx."Counselling conducted on breastfeeding"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason tetanus toxoid (TT) vaccination not provided":
  WC.Only(
  [Immunization: Cx."Reason tetanus toxoid (TT) vaccination not provided"] IND
    where IND.status = 'not-done'
      and Last(Split(IND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).statusReason




define "Counselling conducted on Hep B negative":
  WC.Only(
  [Procedure: Cx."Counselling conducted on Hep B negative"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "No doses of hepatitis B":
  WC.Only(
  [Observation: Cx."No doses of hepatitis B"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Reason Hep B vaccination not provided":
  WC.Only(
  [Immunization: Cx."Reason Hep B vaccination not provided"] IND
    where IND.status = 'not-done'
      and Last(Split(IND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Reason flu vaccine not provided":
  WC.Only(
  [Immunization: Cx."Reason flu vaccine not provided"] IND
    where IND.status = 'not-done'
      and Last(Split(IND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).statusReason




define "Flu immunization provided":
  [Immunization: Cx."Flu immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Date flu immunization was received":
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Hepatitis B-1 immunization provided":
  WC.Only(
  [Immunization: Cx."Hepatitis B-1 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date hepatitis B-1 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Hepatitis B-2 immunization provided":
  WC.Only(
  [Immunization: Cx."Hepatitis B-2 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date hepatitis B-2 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Hepatitis B-3 immunization provided":
  WC.Only(
  [Immunization: Cx."Hepatitis B-3 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date hepatitis B-3 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Tetanus toxoid (TT) 1 immunization provided":
  WC.Only(
  [Immunization: Cx."Tetanus toxoid (TT) 1 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date tetanus toxoid 1 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Tetanus toxoid (TT) 2 immunization provided":
  WC.Only(
  [Immunization: Cx."Tetanus toxoid (TT) 2 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date tetanus toxoid 2 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Tetanus toxoid (TT) 3 immunization provided":
  WC.Only(
  [Immunization: Cx."Tetanus toxoid (TT) 3 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date tetanus toxoid 3 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Tetanus toxoid (TT) 4 immunization provided":
  WC.Only(
  [Immunization: Cx."Tetanus toxoid (TT) 4 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date tetanus toxoid 4 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Tetanus toxoid (TT) 5 immunization provided":
  WC.Only(
  [Immunization: Cx."Tetanus toxoid (TT) 5 immunization provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "Date tetanus toxoid 5 immunization was received":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "IPV first-line support provided":
  WC.Only(
  [Procedure: Cx."IPV first-line support provided"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason IPV first line support not done":
  WC.Only(
  [Procedure: Cx."Reason IPV first line support not done"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "What additional type of care provided":
  WC.Only(
  [Procedure: Cx."What additional type of care provided"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Safety assessement":
  WC.Only(
  [Observation: Cx."Safety assessement"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Has the physical violence happened more often or gotten worse over the past 6 months":
  WC.Only(
  [Observation: Cx."Has the physical violence happened more often or gotten worse over the past 6 months"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Has he ever used a weapon or threatened you with a weapon":
  WC.Only(
  [Observation: Cx."Has he ever used a weapon or threatened you with a weapon"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Has he ever tried to strangle you":
  WC.Only(
  [Observation: Cx."Has he ever tried to strangle you"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Has he ever beaten you when you were pregnant":
  WC.Only(
  [Observation: Cx."Has he ever beaten you when you were pregnant"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Is he violently and constantly jealous of you":
  WC.Only(
  [Observation: Cx."Is he violently and constantly jealous of you"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Do you believe he could kill you":
  WC.Only(
  [Observation: Cx."Do you believe he could kill you"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.boolean




define "Referrals made as part of first-line support and care":
  WC.Only(
  [ServiceRequest: Cx."Referrals made as part of first-line support and care"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Was client referred":
  [Observation: Cx."Was client referred"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Preventive antihelminthic treatment provided":
  WC.Only(
  [Observation: Cx."Preventive antihelminthic treatment provided"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).value as FHIR.CodeableConcept




define "Reason no preventative treatment provided":
  WC.Only(
  [ServiceRequest: Cx."Reason no preventative treatment provided"] SNR
    where SNR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SNR.doNotPerform is true
      and Last(Split(SNR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Counselling conducted on malaria prevention":
  [Procedure: Cx."Counselling conducted on malaria prevention"] P
    where P.status in { 'preparation', 'in-progress', 'on-hold', 'completed' }
      and Last(Split(P.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Reason counselling on malaria prevention was not conducted":
  WC.Only(
  [Procedure: Cx."Counselling conducted on malaria prevention"] PND
    where PND.status = 'not-done'
      and Last(Split(PND.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason malaria prophylaxis not provided":
  [Immunization: Cx."Malaria Prophylaxis"] IND
    where IND.status = 'not-done'
      and Last(Split(IND.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return IND.vaccineCode




define "IPTp-SP dose 1 provided":
  WC.Only(
  [Immunization: Cx."IPTp-SP dose 1 provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "IPTp-SP dose 1 date":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "IPTp-SP dose 2 provided":
  WC.Only(
  [Immunization: Cx."IPTp-SP dose 2 provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "IPTp-SP dose 2 date":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "IPTp-SP dose 3 provided":
  WC.Only(
  [Immunization: Cx."IPTp-SP dose 3 provided"] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).vaccineCode




define "IPTp-SP dose 3 date":
  WC.Only(
  [Immunization] I
    where I.status = 'completed'
      and Last(Split(I.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).occurrence as FHIR.dateTime




define "Referred to hospital":
  WC.Only(
  [ServiceRequest: Cx."Referral to Hospital"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))
  ).code




define "Reason referral not done":
  [ServiceRequest: Cx."Referral to Hospital"] SNR
    where SNR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and SNR.doNotPerform is true
      and Last(Split(SNR.encounter.reference, '/')) = Last(Split(encounter, '/'))
    return SNR.code




define "Emergency referral":
  [ServiceRequest: Cx."Emergency referral"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Date of scheduled referral":
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Location of referral":
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Date referral was made":
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Provider who made referral":
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Referral notes":
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Client history summary":
  [ServiceRequest] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Reason for referral":
  [ServiceRequest: Cx."Reason for referral"] SR
    where SR.status in { 'draft', 'active', 'on-hold', 'completed' }
      and Coalesce(SR.doNotPerform, false) is false
      and Last(Split(SR.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Any treatment given before referral":
  [Observation: Cx."Any treatment given before referral"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Provider's facility":
  [PractitionerRole]



define "Provider's telephone number":
  [PractitionerRole]



define "Reason for closing ANC record":
  [Observation: Cx."Reason for closing ANC record"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Delivery date":
  [Observation: Cx."Delivery date"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Place of delivery":
  [Encounter: Cx."Place of delivery"]



define "Preterm Birth":
  [Observation: Cx."Preterm Birth"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Delivery mode":
  [Observation: Cx."Delivery mode"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Birth weight":
  [Observation: Cx."Birth weight"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Exclusively breastfeeding":
  [Observation: Cx."Exclusively breastfeeding"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Delivery complications":
  [Observation: Cx."Delivery complications"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Date of miscarriage or abortion":
  [Observation: Cx."Date of miscarriage or abortion"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Date of death":
  [Observation: Cx."Date of death"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))




define "Cause of death":
  [Observation: Cx."Cause of death"] O
    where O.status in { 'final', 'amended', 'corrected' }
      and Coalesce(WC.ModifierExtension(O, 'who-notDone').value, false) is false
      and Last(Split(O.encounter.reference, '/')) = Last(Split(encounter, '/'))

