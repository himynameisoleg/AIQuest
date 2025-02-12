import SwiftData
import SwiftUI

struct CharacterListView: View {
    @Query var characters: [Character]

    @Environment(\.modelContext) private var modelContext

    @State private var showCreateView = false
    @State private var confirmationShown = false

    var body: some View {
        NavigationStack {
            List(characters) { character in
                NavigationLink {
                    CharacterDetailView(character: character)
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
                    // FIXME: this deletes the wrong character for some reason
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
    CharacterListView()
        .modelContainer(previewContainer)
}
