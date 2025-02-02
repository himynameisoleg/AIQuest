import Foundation

struct OllamaResponse: Codable {
    let response: String
    let model: String
}
struct OllamaCharacterCreate: Codable {
    var name: String
    var title: String
    var motivation: String
    var backstory: String
}

struct OllamaQuestCreate: Codable {
    var title: String
    var task: String
    var desc: String
    var experienceReward: Int
    var goldReward: Int
}
