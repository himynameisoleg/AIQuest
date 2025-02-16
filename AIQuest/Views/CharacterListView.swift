import SwiftData
import SwiftUI

struct CharacterListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Character.name) private var characters: [Character]

    var body: some View {
        ListCharacters(characters: characters)
    }
}

private struct ListCharacters: View {
    var characters: [Character]
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @State private var isEditorPresented = false
    @State private var confirmationShown = false
    @State private var characterToDelete: Character?

    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedCharacter) {
            ForEach(characters) { character in
                NavigationLink(value: character) {
                    CharacterRow(character: character)
                }
                .swipeActions(allowsFullSwipe: false) {
                    Button(role: .destructive) {
                        confirmDeletion(of: character)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }
                }
            }
        }
        .confirmationDialog(
                "Delete Character?",
                isPresented: $confirmationShown,
                titleVisibility: .visible
            ) {
                Button("Delete", role: .destructive) {
                    if let character = characterToDelete {
                        removeCharacter(character)
                    }
                }
                Button("Cancel", role: .cancel) {
                    characterToDelete = nil
                }
            }
        .sheet(isPresented: $isEditorPresented) {
            CharacterEditor(character: nil)
        }
        .overlay {
            if characters.isEmpty {
                ContentUnavailableView {
                    Label(
                        "The halls are empty.",
                        systemImage: "person.circle")
                } description: {
                    AddCharacterButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddCharacterButton(isActive: $isEditorPresented)
            }
        }
    }

    private func confirmDeletion(of character: Character) {
          characterToDelete = character
          confirmationShown = true
      }

    private func removeCharacter(_ character: Character) {
         if navigationContext.selectedCharacter?.name == character.name {
             navigationContext.selectedCharacter = nil
         }
         modelContext.delete(character)
         characterToDelete = nil
     }
}

private struct AddCharacterButton: View {
    @Binding var isActive: Bool

    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a Character", systemImage: "plus")
                .help("Add a Character")
        }
    }
}

#Preview("CharacterListView") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            CharacterListView()
        }
        .environment(NavigationContext())
    }
}

#Preview("Empty CharacterListView") {
    NavigationStack {
        CharacterListView()
    }
    .environment(NavigationContext())
}

#Preview("ListCategories") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            List {
                ListCharacters(characters: [.wizard, .artificer])
            }
        }
        .environment(NavigationContext())
    }
}

#Preview("AddCharacterButton") {
    AddCharacterButton(isActive: .constant(false))
}
