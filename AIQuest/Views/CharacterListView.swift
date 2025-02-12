import SwiftUI
import SwiftData

struct CharacterListView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Character.name) private var characters: [Character]
    @State private var isReloadPresented = false

    @State private var showCreateView = false
    @State private var confirmationShown = false

    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedCharacterName) {
            ListCharacters(characters: characters)
        }


//        NavigationStack {
//            List(characters) { character in
//                NavigationLink {
//                    CharacterDetailView(character: character)
//                } label: {
//                    CharacterRow(character: character)
//                }
//                .swipeActions(allowsFullSwipe: false) {
//                    Button {
//                        confirmationShown = true
//                    } label: {
//                        Label("Delete", systemImage: "trash.fill")
//                    }
//                    .tint(.red)
//                }
//                .confirmationDialog(
//                    "Delete Character?",
//                    isPresented: $confirmationShown
//                ) {
//                    Button("Delete", role: .destructive) {
//                    // FIXME: this deletes the wrong character for some reason
//                        modelContext.delete(character)
//                    }
//                }
//            }
//            .navigationTitle("Heroes")
//            .toolbar {
//                ToolbarItem {
//                    Button("Add") {
//                        showCreateView = true
//                    }
//                }
//            }
//        }
//        .sheet(isPresented: $showCreateView) {
//            NavigationStack {
//                CharacterCreateView(showCreateView: $showCreateView)
//                    .navigationTitle("Create Character")
//            }
//        }
    }
}

private struct ListCharacters: View {
    var characters: [Character]
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        ForEach(characters) { character in
            NavigationLink(character.name, value: character.name)
        }
//        .onDelete(perform: removeCharacters)
    }

//TODO: delete characters same as quests
//    private func removeCharacters(at indexSet: IndexSet) {
//        for index in indexSet {
//            let characterToDelete = characters[index]
//            if navigationContext.selectedCharacterName?.persistentModelID == characterToDelete.persistentModelID {
//                navigationContext.selectedCharacterName = nil
//            }
//            modelContext.delete(characterToDelete)
//        }
//    }
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
