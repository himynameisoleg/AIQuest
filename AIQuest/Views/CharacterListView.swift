import SwiftData
import SwiftUI

struct CharacterListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Character.name) private var characters: [Character]
    @State private var isReloadPresented = false

    @State private var showCreateView = false
    @State private var confirmationShown = false

    var body: some View {
        ListCharacters(characters: characters)
    }
}

private struct ListCharacters: View {
    var characters: [Character]
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @State private var isEditorPresented = false

    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedCharacter) {
            ForEach(characters) { character in
                NavigationLink(
                    value: character,
                    label: {
                        CharacterRow(character: character)
                    })
            }
            .onDelete(perform: removeCharacters)
        }
        .sheet(isPresented: $isEditorPresented) {
            CharacterEditor(character: nil)
        }
        .overlay {
            if characters.isEmpty {
                ContentUnavailableView {
                    Label(
                        "No characters yet",
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

    private func removeCharacters(at indexSet: IndexSet) {
        for index in indexSet {
            let characterToDelete = characters[index]
            if navigationContext.selectedCharacter?.name == characterToDelete.name
            {
                navigationContext.selectedCharacter = nil
            }
            modelContext.delete(characterToDelete)
        }
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
