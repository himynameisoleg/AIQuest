import SwiftUI

struct CharacterDetailView: View {
    var character: Character
    @Environment(\.modelContext) private var modelContext

    @Binding var showEditView: Bool
    @State private var isExpanded: Bool = false
    @State private var isLoading: Bool = false
    @State private var resultText: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.title.bold())

            Text(character.title)
                .padding(.bottom)

            // TODO: simplify class selector to avoid this weird NSManagedObject bug
            Text(
                "Level \(1 + (character.experience / 100)) \(character.className)"
            )
            .font(.subheadline.bold())
            .padding(.bottom)

            Text(character.backstory)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(isExpanded ? nil : 5)

            if character.backstory.count > 200 {
                Button(isExpanded ? "Read Less" : "Read More") {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .font(.caption)
                .foregroundColor(.blue)
            }

            HStack {
                Text("Exp: \(character.experience)")
                    .font(.subheadline.bold())

                Spacer()

                Text("Gold: \(character.gold)")
                    .font(.subheadline.bold())
            }
            .padding(.vertical)

            ProgressView(value: Double(character.experience % 100), total: 100)
                .tint(.blue)
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .padding(.bottom)
                .progressViewStyle(LinearProgressViewStyle())

            Text(resultText)

            QuestList(character: character)

            Button(action: generateQuest) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity)
                } else {
                    Text("Generate Quest")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .disabled(isLoading)
            .background(isLoading ? Color.green.opacity(0.5) : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)

        }
        .padding()
        .toolbar {
            Button("Edit") {
                showEditView = true
            }
        }
        .sheet(isPresented: $showEditView) {
            NavigationStack {
                CharacterEditView(
                    character: character, showEditView: $showEditView
                )
                .navigationTitle("Edit Character")
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
            "prompt": Prompt.createQuestPrompt(character: character).message,
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

                    print(quest)

                    let newQest = Quest.init(
                        title: quest.title, task: quest.task, desc: quest.desc,
                        experienceReward: quest.experienceReward,
                        goldReward: quest.goldReward)

                    character.quests.append(newQest)

                    do {
                        try modelContext.save()
                    } catch {
                        print("failed to save context: \(error)")
                    }

                } catch {
                    resultText =
                        "Error decoding quest: \(error.localizedDescription)"
                }

            }
        }.resume()
    }
}

#Preview {
    @Previewable @State var visible: Bool = false
    NavigationStack {
        CharacterDetailView(
            character: Character.sampleCharacters[0], showEditView: $visible
        )
    }
}
