import Foundation
import SwiftData

@Model
final class Quest: Identifiable {
    var id: UUID = UUID()
    var title: String
    var progressionStage: Int
    var task: String
    var desc: String
    var difficulty: String
    var experienceReward: Int
    var goldReward: Int
    var isCompleted: Bool
    var completedDate: Date?
    var character: Character?

    init(
        title: String,
        task: String,
        progressionStage: Int = 0,
        desc: String,
        difficulty: String,
        experienceReward: Int,
        goldReward: Int,
        isCompleted: Bool = false
    ) {
        self.title = title
        self.task = task
        self.progressionStage = progressionStage
        self.desc = desc
        self.difficulty = difficulty
        self.experienceReward = experienceReward
        self.goldReward = goldReward
        self.isCompleted = isCompleted
    }
}

enum QuestDifficulty: String, CaseIterable, Identifiable {
    case SideQuest = "Side Quest"
    case Heroic = "Heroic"
    case Epic = "Epic"
    var id: Self { self }
}

func getLastCompletedQuest(from quests: [Quest]) -> Quest? {
    return
        quests
        .filter { $0.isCompleted && $0.completedDate != nil }
        .sorted { $0.completedDate! > $1.completedDate! }
        .first
}
