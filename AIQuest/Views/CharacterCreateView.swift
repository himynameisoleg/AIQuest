import SwiftUI

struct CharacterCreateView: View {
    @Binding var showCreateView: Bool
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
        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    showCreateView = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {

                Button("Create") {
                    let newCharacter = Character.init(
                        name: name, title: title, habit: habit,
                        className: selectedClass.rawValue, backstory: backstory,
                        motivation: motivation)

                    modelContext.insert(newCharacter)
                    // TODO: generate the QUESTS!
                    
                    showCreateView = false
                }
            }
        }
    }
}

#Preview {
    @Previewable @State var visible: Bool = true
    CharacterCreateView(showCreateView: $visible)
}
