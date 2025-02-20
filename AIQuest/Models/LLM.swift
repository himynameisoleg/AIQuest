import Foundation

let LLM_MODEL = "llama3.2"
let LLM_BASE_URL = "http://localhost:11434/api/generate"

//let selectedLLMProvider: LLMProvider = .ollama
let selectedLLMProvider: LLMProvider = .gemini

enum LLMProvider {
    case ollama
    case gemini

    var url: URL? {
        switch self {
        case .ollama:
            return URL(string: "http://localhost:11434/api/generate")
        case .gemini:
            let geminiKey = getGeminiKey()
            return URL(
                string:
                    "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.5-flash:generateContent?key=\(geminiKey)"
            )
        }
    }

    func requestBody(prompt: String) -> [String: Any] {
        switch self {
        case .ollama:
            return [
                "model": LLM_MODEL,
                "prompt": prompt,
                "stream": false,
            ]
        case .gemini:
            return [
                "contents": [
                    [
                        "parts": [
                            [
                                "text": prompt
                            ]
                        ]
                    ]
                ]
            ]
        }
    }

    func parseResponse<T: Decodable>(data: Data, responseType: T.Type) throws
        -> T
    {
        switch self {
        case .ollama:
            let decodedResponse = try JSONDecoder().decode(
                OllamaResponse.self, from: data)
            guard let jsonData = decodedResponse.response.data(using: .utf8)
            else {
                throw NSError(
                    domain: "Invalid response format", code: 0, userInfo: nil)
            }
            return try JSONDecoder().decode(responseType, from: jsonData)
        case .gemini:
            let decodedResponse = try JSONDecoder().decode(
                GeminiResponse.self, from: data)
            guard
                let jsonData = decodedResponse.candidates.first?.content.parts
                    .first?.text.data(using: .utf8)
            else {
                throw NSError(
                    domain: "Invalid response format", code: 0, userInfo: nil)
            }
            return try JSONDecoder().decode(responseType, from: jsonData)
        }
    }

}

struct GeminiResponse: Codable {
    struct Candidate: Codable {
        struct Content: Codable {
            struct Part: Codable {
                let text: String
            }
            let parts: [Part]
        }
        let content: Content
    }
    let candidates: [Candidate]
}

struct OllamaResponse: Codable {
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

private func getGeminiKey() -> String {
    // TODO: can this be done with .env file instead of .xcconfig?
    guard
        let apiKey = Bundle.main.object(forInfoDictionaryKey: "GEMINI_API_KEY")
            as? String,
        !apiKey.isEmpty
    else {
        fatalError(
            "❌ API Key is missing or empty. Ensure it is set in Configs"
        )
    }
    return apiKey
}
