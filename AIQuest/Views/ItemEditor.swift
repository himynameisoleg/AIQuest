import SwiftData
import SwiftUI

struct ItemEditor: View {
    let item: Item?

    private var editorTitle: String {
        item == nil ? "Add Item" : "Edit Item"
    }

    @State private var name = ""
    @State private var desc = ""
    @State private var value: Int = 0
    @State private var levelRequired: Int = 0
    @State private var selectedCharacter: Character?

    @State private var isLoading = false

    @Environment(\.dismiss) private var dismiss
    @Environment(\.modelContext) private var modelContext

    @Query(sort: \Character.name) private var characters: [Character]

    var body: some View {
        NavigationStack {
            Form {
                Section("Basic Details") {
                    TextField("Item Name", text: $name)
                    TextField("Description", text: $desc)
                }
                Section("Gold Cost") {
                    TextField("Gold", value: $value, format: .number)
//                    TextField(
//                        "Level Required", value: $levelRequired, format: .number
//                    )
                }
//                Section("Someone buying this?") {
//                    Picker("Character", selection: $selectedCharacter) {
//                        Text("Select a character").tag(nil as Character?)
//                        ForEach(characters) { character in
//                            Text(character.name).tag(character as Character?)
//                        }
//                    }
//                }
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
                    .disabled(name.isEmpty && desc.isEmpty && value == 0)
                }

//                ToolbarItem(placement: .automatic) {
//                    Button {
//                        enerateQuest()
//                    } label: {
//                        Image(systemName: "sparkles")
//                    }
//                    .disabled(task.isEmpty || selectedCharacter == nil)
//                }

                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel", role: .cancel) {
                        dismiss()
                    }
                }
            }
            .onAppear {
                if let item {
                    // Edit the incoming item.
                    name = item.name
                    desc = item.desc
                    value = item.value
                    levelRequired = item.experienceRequirement / 100
                }
            }
            .alert("Generating a new item", isPresented: $isLoading) {
                //
            } message: {
                Text("Please wait...")
            }
        }
    }

    private func save() {
        if let item {
            // Edit the item.
            item.name = name
            item.desc = desc
            item.value = value
            item.experienceRequirement = levelRequired * 100
        } else {
            // Add an item.
            let newItem = Item(
                name: name,
                desc: desc,
                value: value,
                experienceRequirement: levelRequired * 100
            )
            newItem.character = selectedCharacter
            modelContext.insert(newItem)
        }
    }
}

#Preview("Add item") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemEditor(item: nil)
    }
}

#Preview("Edit item") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemEditor(item: .bootsOfStriding)
    }
}
