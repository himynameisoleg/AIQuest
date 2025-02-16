import SwiftUI

struct CharacterEditView: View {
    var character: Character
    @Binding var showEditView: Bool

    @Environment(\.modelContext) private var modelContext

    @State private var name: String = ""
    @State private var title: String = ""
    @State private var habit: String = ""
    @State private var selectedClass: CharacterClass = .Wizard
    @State private var backstory: String = ""
    @State private var motivation: String = ""
    @State private var experience: Int = 0
    @State private var gold: Int = 0

    var body: some View {
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
                TextField("Gold", value: $gold, formatter: NumberFormatter())
            }
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    showEditView = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {

                Button("Save") {
                    character.name = name
                    character.title = title
                    character.habit = habit
                    character.dndClass = selectedClass.rawValue
                    character.backstory = backstory
                    character.motivation = motivation
                    character.experience = experience
                    character.gold = gold

                    do {
                        try modelContext.save()
                    } catch {
                        print("failed to save context: \(error)")
                    }

                    showEditView = false
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var visible: Bool = true
    CharacterEditView(
        character: Character.sampleCharacters.first!, showEditView: $visible)
}
