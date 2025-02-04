import Foundation
import SwiftData

@Model
class Quest: Identifiable {
    var id: UUID = UUID()
    var title: String
    var task: String
    var desc: String
    var experienceReward: Int
    var goldReward: Int
    var isCompleted: Bool
    var completedDate: Date?
    
    init(id: UUID = UUID(), title: String, task: String, desc: String, experienceReward: Int, goldReward: Int, isCompleted: Bool = false) {
            self.id = id
            self.title = title
            self.task = task
            self.desc = desc
            self.experienceReward = experienceReward
            self.goldReward = goldReward
            self.isCompleted = isCompleted
        }
}

func getLastCompletedQuest(from quests: [Quest]) -> Quest? {
    return quests
        .filter { $0.isCompleted && $0.completedDate != nil }
        .sorted { $0.completedDate! > $1.completedDate! }
        .first
}
