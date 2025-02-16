import Foundation

let LLM_MODEL = "llama3.2"
let LLM_BASE_URL = "http://localhost:11434/api/generate"
//let LLM_API_KEY = ""

//enum LLMProvider {
//    case ollama
//    case gemini
//
//    var url: URL? {
//        switch self {
//        case .ollama:
//            return URL(string: "http://localhost:11434/api/generate")
//        case .gemini:
//            return URL(string: "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(LLM_API_KEY)")
//        }
//    }
//}

struct LLMResponse: Codable {
    let response: String
    let model: String
}
struct LLMCharacterCreate: Codable {
    var name: String
    var title: String
    var motivation: String
    var backstory: String
}

struct LLMQuestCreate: Codable {
    var title: String
    var desc: String
    var experienceReward: Int
    var goldReward: Int
}
