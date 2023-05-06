parameter encounter String

define "Terminology Ambiguity":
  [Encounter: Cx."ValueSet"]

define "Where Expression Ambiguity":
  [Encounter] E
    where E.id = Id(encounter)