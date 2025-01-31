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

    var body: some View {
        Form {
            Section("Basic Details") {
                TextField("Name", text: $name)
                TextField("Title", text: $title)
//                Picker("Class", selection: $selectedClass) {
//                    ForEach(CharacterClass.allCases) { category in
//                        Text(category.rawValue).tag(category)
//                    }
//                }
                TextField("Habit", text: $habit)
            }
            Section("Backstory") {
                TextEditor(text: $backstory)
            }
            Section("Motivation") {
                TextEditor(text: $motivation)
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
                    print("className before save: \(character.className)")
                    print(selectedClass.rawValue)
                    
                    character.name = name
                    character.title = title
                    character.habit = habit
//                TODO: why is this setting NSManagedObject instead of the String?
//                    character.className = selectedClass.rawValue
                    character.backstory = backstory
                    character.motivation = motivation
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
