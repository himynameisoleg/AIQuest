enum CharacterClass: String, CaseIterable, Identifiable {
    case Artificer = "Artificer"
    case Druid = "Druid"
    case Fighter = "Fighter"
    case Rogue = "Rogue"
    case Wizard = "Wizard"
    var id: Self { self }
}
