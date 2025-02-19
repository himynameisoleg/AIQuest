import SwiftData
import SwiftUI

struct QuestEditor: View {
    let quest: Quest?

    private var editorTitle: String {
        quest == nil ? "Add Quest" : "Edit Quest"
    }

    @State private var title = ""
    @State private var task = ""
    @State private var desc = ""
    @State private var experienceReward: Int = 10
    @State private var goldReward: Int = 10
    @State private var selectedCharacter: Character?

    @State private var isLoading = false

    @State private var selectedDifficulty: QuestDifficulty = .SideQuest
    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Character.name) private var characters: [Character]

    var body: some View {
        NavigationStack {
            Form {
                Picker("Character", selection: $selectedCharacter) {
                    Text("Select a character").tag(nil as Character?)
                    ForEach(characters) { character in
                        Text(character.name).tag(character as Character?)
                    }
                }
                Picker("Difficulty", selection: $selectedDifficulty) {
                    ForEach(
                        QuestDifficulty.allCases,
                        id: \.self
                    ) { difficulty in
                        Text(difficulty.rawValue).tag(difficulty)
                    }
                }
                Section("Basic Details") {
                    TextField("Task", text: $task)
                    TextField("Quest Title", text: $title)
                }
                Section("Descripton") {
                    TextEditor(text: $desc)
                }
                Section("Rewards") {
                    HStack {
                        Text("Exp:")
                        TextField(
                            "Exp", value: $experienceReward, format: .number)

                        Spacer()

                        Text("Gold:")
                        TextField("Gold", value: $goldReward, format: .number)
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text(editorTitle)
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
                            save()
                            dismiss()
                        }
                    }
                    // Require a category to save changes.
                    .disabled($selectedCharacter.wrappedValue == nil)
                }

                ToolbarItem(placement: .automatic) {
                    Button {
                        generateQuest()
                    } label: {
                        Image(systemName: "sparkles")
                    }
                    .disabled(task.isEmpty || selectedCharacter == nil)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let quest {
                    // Edit the incoming quest.
                    title = quest.title
                    task = quest.task
                    desc = quest.desc
                    experienceReward = quest.experienceReward
                    goldReward = quest.goldReward
                    selectedCharacter = quest.character

                }
            }
            .alert("Generating a new quest", isPresented: $isLoading) {
                //
            } message: {
                Text("Please wait...")
            }
        }
    }

    func generateQuest() {
        isLoading = true
        guard let url = selectedLLMProvider.url else {
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = Prompt.createQuestPrompt(
            character: characters.first(where: {
                $0.name == selectedCharacter?.name
            })!,
            task: task,
            difficulty: selectedDifficulty.rawValue
        ).message

        let requestBody = selectedLLMProvider.requestBody(prompt: prompt)
        request.httpBody = try? JSONSerialization.data(
            withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    print("Error: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }

                do {
                    let quest: LLMQuestCreate =
                        try selectedLLMProvider.parseResponse(
                            data: data, responseType: LLMQuestCreate.self)

                    title = quest.title
                    desc = quest.desc
                    experienceReward = quest.experienceReward
                    goldReward = quest.goldReward

                } catch {
                    print("Error decoding quest: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    private func save() {
        if let quest {
            // Edit the quest.
            quest.title = title
            quest.task = task
            quest.desc = desc
            quest.experienceReward = experienceReward
            quest.goldReward = goldReward
        } else {
            // Add an quest.
            let newQuest = Quest(
                title: title,
                task: task,
                desc: desc,
                difficulty: selectedDifficulty.rawValue,
                experienceReward: experienceReward,
                goldReward: goldReward
            )
            newQuest.character = selectedCharacter
            modelContext.insert(newQuest)
        }
    }
}

#Preview("Add quest") {
    ModelContainerPreview(ModelContainer.sample) {
        QuestEditor(quest: nil)
    }
}

#Preview("Edit quest") {
    ModelContainerPreview(ModelContainer.sample) {
        QuestEditor(quest: .daily)
    }
}
