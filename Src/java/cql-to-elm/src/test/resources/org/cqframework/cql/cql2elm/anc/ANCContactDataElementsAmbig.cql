library ANCContactDataElementsAmbig

using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'

include WHOCommon called WC
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