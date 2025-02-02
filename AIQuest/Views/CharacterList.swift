import SwiftData
import SwiftUI

struct CharacterList: View {
    @Query var characters: [Character]

    @Environment(\.modelContext) private var modelContext

    @State private var showCreateView = false
    @State private var showEditView = false
    @State private var confirmationShown = false

    var body: some View {
        NavigationSplitView {
            List(characters) { character in
                NavigationLink {
                    CharacterDetailView(
                        character: character, showEditView: $showEditView)
                } label: {
                    CharacterRow(character: character)
                }
                .swipeActions(allowsFullSwipe: false) {
                    Button {
                        confirmationShown = true
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                    .tint(.red)
                }
                .confirmationDialog(
                    "Delete Character?",
                    isPresented: $confirmationShown
                ) {
                    Button("Delete", role: .destructive) {
                        modelContext.delete(character)
                    }
                }
            }
            .navigationTitle("Heroes")
            .toolbar {
                ToolbarItem {
                    Button("Add") {
                        showCreateView = true
                    }
                }
            }

            // TODO: remove
            Button("Sample Character", systemImage: "person.fill") {
                modelContext.insert(Character.sampleCharacters.first!)
            }
        } detail: {
            Text("Select your Hero")
        }
        .sheet(isPresented: $showCreateView) {
            NavigationStack {
                CharacterCreateView(showCreateView: $showCreateView)
                    .navigationTitle("Create Character")
            }
        }

    }
}

#Preview {
    CharacterList()
        .modelContainer(previewContainer)
}
