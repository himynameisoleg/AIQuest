import Foundation

struct Quest: Hashable, Codable, Identifiable {
    var id: UUID = UUID()
    var title: String
    var task: String
    var description: String
    var experienceReward: Int
    var goldReward: Int
}
