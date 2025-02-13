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
    @State private var className = ""
    @State private var backstory = ""
    @State private var motivation = ""
    @State private var experience: Int = 0
    @State private var gold: Int = 0

    @State private var selectedClass: CharacterClass = .Wizard

    @State private var animateHighlight = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Character.name) private var characters: [Character]

    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Details") {
                    TextField("Name", text: $name)
                        .autocorrectionDisabled()
                    TextField("Title", text: $title)
                        .autocorrectionDisabled()
                    Picker("Class", selection: $selectedClass) {
                        ForEach(CharacterClass.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    TextField("Habit", text: $habit)
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
                        // TODO: AI Gen
                    } label: {
                        Image(systemName: "sparkles")
                            .foregroundStyle(.blue)
                            .scaleEffect(animateHighlight ? 1.2 : 1.0)
                            .opacity(animateHighlight ? 1.0 : 0.6)
                            .animation(
                                .easeInOut(duration: 1.0)
                                    .repeatForever(autoreverses: true),
                                value: animateHighlight
                            )
                    }
                    .onAppear {
                        animateHighlight = true
                    }
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
                    className = character.className
                    backstory = character.backstory
                    motivation = character.motivation
                    experience = character.experience
                    gold = character.gold
                }
            }
        }
    }

    private func save() {
        if let character {
            name = character.name
            title = character.title
            habit = character.habit
            className = selectedClass.rawValue
            backstory = character.backstory
            motivation = character.motivation
            experience = character.experience
            gold = character.gold
        } else {
            let newCharacter = Character(
                name: name,
                title: title,
                habit: habit,
                className: className,
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
