import Foundation
import SwiftData
import SwiftUI

@Model
final class Character: Identifiable {
    var id: UUID = UUID()
    var name: String
    var title: String
    var habit: String
    var dndClass: String
    var backstory: String
    var motivation: String
    var experience: Int
    var gold: Int
    var icon: String

    @Relationship(deleteRule: .cascade, inverse: \Quest.character)
    var quests = [Quest]()

    @Relationship(deleteRule: .cascade, inverse: \Item.character)
    var items = [Item]()

    init(
        name: String, title: String, habit: String, dndClass: String,
        backstory: String, motivation: String, experience: Int = 0,
        gold: Int = 0, items: [Item] = [], quests: [Quest] = []
    ) {
        self.name = name
        self.title = title
        self.habit = habit
        self.dndClass = dndClass
        self.backstory = backstory
        self.motivation = motivation
        self.experience = experience
        self.gold = gold
        self.icon = mapClassToIcon(dndClass: dndClass)
        self.quests = quests
        self.items = items
    }
}

func mapClassToIcon(dndClass: String) -> String {
    switch dndClass {
    case "Artificer":
        return "⚙️"
    case "Druid":
        return "🧝‍♀️"
    case "Fighter":
        return "⚔️"
    case "Rogue":
        return  "🗡️"
    case "Wizard":
        return  "🧙‍♂️"
    default:
        return "👨‍🎓"
    }
}

func mapClassToColor(dndClass: String) -> Color {
    switch dndClass {
    case "Artificer":
        return .brown
    case "Druid":
        return .green
    case "Fighter":
        return .red
    case "Rogue":
        return .purple
    case "Wizard":
        return .blue
    default:
        return .primary
    }
}

enum CharacterClass: String, CaseIterable, Identifiable {
    case Artificer = "Artificer"
    case Druid = "Druid"
    case Fighter = "Fighter"
    case Rogue = "Rogue"
    case Wizard = "Wizard"
    var id: Self { self }
}
