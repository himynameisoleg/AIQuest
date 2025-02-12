import Foundation
import SwiftData
import SwiftUI

@Model
final class Character: Identifiable {
    var id: UUID = UUID()
    var name: String
    var title: String
    var habit: String
    var className: String
    var backstory: String
    var motivation: String
    var experience: Int
    var gold: Int
    var backpack: [Item]
    var icon: String

    @Relationship(deleteRule: .cascade, inverse: \Quest.character)
    var quests = [Quest]()

    init(
        name: String, title: String, habit: String, className: String,
        backstory: String, motivation: String, experience: Int = 0,
        gold: Int = 0, backpack: [Item] = [], quests: [Quest] = []
    ) {
        self.name = name
        self.title = title
        self.habit = habit
        self.className = className
        self.backstory = backstory
        self.motivation = motivation
        self.experience = experience
        self.gold = gold
        self.backpack = backpack
        self.quests = quests
        self.icon = mapTraits(className)
    }
}

func mapTraits(_ className: String) -> String {
    switch className {
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

enum CharacterClass: String, CaseIterable, Identifiable {
    case Artificer = "Artificer"
    case Druid = "Druid"
    case Fighter = "Fighter"
    case Rogue = "Rogue"
    case Wizard = "Wizard"
    var id: Self { self }
}
