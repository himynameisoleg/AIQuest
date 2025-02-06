import SwiftUI

struct QuestCreateView: View {
    var character: Character
    @Binding var showQuestCreateView: Bool
    @Environment(\.modelContext) private var modelContext

    @State private var isLoading = false
    @State private var contentVisible = false
    @State private var resultText = ""

    @State private var task = ""
    @State private var title = ""
    @State private var desc = ""
    @State private var experienceReward = 0
    @State private var goldReward = 0
    
    @State private var selectedDifficulty: String = "Side Quest"
    let difficultyOptions = ["Side Quest", "Heroic", "Epic"]

    var body: some View {
        Form {
            Section("Enter Task") {
                TextField("\"Read 25 minutes\"", text: $task)
                Picker("Difficulty", selection: $selectedDifficulty) {
                    ForEach(difficultyOptions, id: \.self) { difficulty in
                        Text(difficulty).tag(difficulty)
                    }
                }
            }

            if contentVisible {
                Section("Title") {
                    TextField("", text: $title)
                }
                Section("Quest Objective") {
                    TextEditor(text: $desc)
                        .frame(height: 160)
                }
                Section("Rewards") {
                    HStack {
                        RewardChip(
                            value: experienceReward,
                            label: "XP",
                            color: .blue
                        )
                        RewardChip(
                            value: goldReward,
                            label: "Gold",
                            color: Color(red: 212/255, green: 175/255, blue: 55/255)
                        )
                    }
                    .padding(.vertical)
                }
            }

            Button(action: generateQuest) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity)
                } else {
                    Text("AI Generate")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .disabled(isLoading || task.isEmpty)
            .background((isLoading || task.isEmpty) ? Color.green.opacity(0.5) : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    showQuestCreateView = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {
                Button("Create") {
                    let newQest = Quest.init(
                        title: title, task: task, desc: desc,
                        experienceReward: experienceReward,
                        goldReward: goldReward)

                    character.quests.append(newQest)

                    do {
                        try modelContext.save()
                    } catch {
                        print("failed to save context: \(error)")
                    }
                    showQuestCreateView = false
                }
            }
        }
    }

    func generateQuest() {
        isLoading = true
        guard let url = URL(string: "http://localhost:11434/api/generate")
        else {
            resultText = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let requestBody: [String: Any] = [
            "model": "mistral",
            "prompt": Prompt.createQuestPrompt(character: character, task: task, difficulty: selectedDifficulty).message,
            "stream": false,
        ]

        request.httpBody = try? JSONSerialization.data(
            withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    resultText = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    resultText = "No data received"
                    return
                }

                guard
                    let decodedResponse = try? JSONDecoder().decode(
                        OllamaResponse.self, from: data)
                else {
                    resultText = "Error decoding response"
                    return
                }
                
                guard let jsonData = decodedResponse.response.data(using: .utf8)
                else {
                    resultText = "Error converting string to Data"
                    return
                }

                print(decodedResponse)

                do {
                    let quest = try JSONDecoder().decode(
                        OllamaQuestCreate.self, from: jsonData)

                    title = quest.title
                    desc = quest.desc
                    experienceReward = Int(quest.experienceReward)
                    goldReward = Int(quest.goldReward)
                    
                    contentVisible = true
                } catch {
                    resultText =
                        "Error decoding quest: \(error.localizedDescription)"
                }

            }
        }.resume()
    }
}

#Preview {
    @Previewable @State var visible: Bool = true
    QuestCreateView(
        character: Character.sampleCharacters.first!,
        showQuestCreateView: $visible)
}
