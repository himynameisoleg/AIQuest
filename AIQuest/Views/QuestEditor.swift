import SwiftUI
import SwiftData

struct QuestEditor: View {
    let quest: Quest?

    private var editorTitle: String {
        quest == nil ? "Add Quest" : "Edit Quest"
    }

    @State private var title = ""
    @State private var task = ""
    @State private var desc = ""
    @State private var experienceReward: Int = 0
    @State private var goldReward: Int = 0
    @State private var selectedCharacter: Character?

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Character.name) private var characters: [Character]

    var body: some View {
        NavigationStack {
            Form {
                TextField("Title", text: $title)

                Picker("Category", selection: $selectedCharacter) {
                    Text("Select a character").tag(nil as Character?)
                    ForEach(characters) { character in
                        Text(character.name).tag(character as Character?)
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
                    // TODO: other params
                }
            }
        }
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

