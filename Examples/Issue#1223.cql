library Repro version '0.1.0'

using USCore version '3.1.1'
//using FHIR version '4.0.1'

include FHIRHelpers version '4.0.1'

context Patient

define "Name":
  Patient.name.given[0]