import SwiftData
import SwiftUI

struct CharacterEditor: View {
    let character: Character?

    private var editorTitle: String {
        character == nil ? "Add Character" : "Edit Character"
    }

    @State private var name = ""
    @State private var title = ""
    @State private var habit = ""
    @State private var dndClass = ""
    @State private var backstory = ""
    @State private var motivation = ""
    @State private var experience: Int = 0
    @State private var gold: Int = 0

    @State private var selectedClass: CharacterClass = .Artificer
    @State private var isLoading = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Character.name) private var characters: [Character]

    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Details") {
                    TextField("Habit", text: $habit)
                    TextField("Name", text: $name)
                        .autocorrectionDisabled()
                    TextField("Title", text: $title)
                        .autocorrectionDisabled()
                    Picker("Class", selection: $selectedClass) {
                        ForEach(CharacterClass.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                }
                Section("Backstory") {
                    TextEditor(text: $backstory)
                }
                Section("Motivation") {
                    TextEditor(text: $motivation)
                }
                Section("Exp Override") {
                    TextField(
                        "Experience Points", value: $experience,
                        formatter: NumberFormatter())
                }
                Section("Gold override") {
                    TextField(
                        "Gold", value: $gold, formatter: NumberFormatter())
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
                    .disabled(habit.isEmpty)

                }

                ToolbarItem(placement: .automatic) {
                    Button {
                        generateCharacter()
                    } label: {
                        Image(systemName: "sparkles")
                    }
                    .disabled(habit.isEmpty)
                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let character {
                    name = character.name
                    title = character.title
                    habit = character.habit
                    dndClass = character.dndClass
                    backstory = character.backstory
                    motivation = character.motivation
                    experience = character.experience
                    gold = character.gold
                }
            }
            .alert("Generating a new character", isPresented: $isLoading) {
                //
            } message: {
                Text("Please wait...")
            }
        }
    }

    func generateCharacter() {
        isLoading = true
        guard let url = selectedLLMProvider.url else {
            print("Invalid URL")
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let prompt = Prompt.createCharacterPrompt(habit: habit).message

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
                    let character: LLMCharacterCreate =
                        try selectedLLMProvider.parseResponse(
                            data: data, responseType: LLMCharacterCreate.self)

                    name = character.name
                    title = character.title
                    backstory = character.backstory
                    motivation = character.motivation

                } catch {
                    print("Error decoding quest: \(error.localizedDescription)")
                }
            }
        }.resume()
    }

    private func save() {
        if let character {
            name = character.name
            title = character.title
            habit = character.habit
            dndClass = character.dndClass
            backstory = character.backstory
            motivation = character.motivation
            experience = character.experience
            gold = character.gold
        } else {
            let newCharacter = Character(
                name: name,
                title: title,
                habit: habit,
                dndClass: selectedClass.rawValue,
                backstory: backstory,
                motivation: motivation,
                experience: experience,
                gold: gold
            )
            modelContext.insert(newCharacter)
        }
    }
}

#Preview("Add character") {
    ModelContainerPreview(ModelContainer.sample) {
        CharacterEditor(character: nil)
    }
}

#Preview("Edit character") {
    ModelContainerPreview(ModelContainer.sample) {
        CharacterEditor(character: .wizard)
    }
}
