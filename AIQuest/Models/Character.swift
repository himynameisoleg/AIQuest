import Foundation
import SwiftData

@Model
class Character: Identifiable {
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
    var quests: [Quest]

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
    }
}
