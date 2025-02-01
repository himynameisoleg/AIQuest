import SwiftData
import SwiftUI

struct CharacterList: View {
    @Query var characters: [Character]

    @Environment(\.modelContext) private var modelContext

    @State private var showCreateView = false
    @State private var showEditView = false

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
                    Button(role: .destructive) {
                        modelContext.delete(character)
                    } label: {
                        Label("Delete", systemImage: "trash.fill")
                    }
                }
            }
            Button("Add Example Hero") {
                modelContext.insert(Character.sampleCharacters.first!)
            }
            .padding()
            .navigationTitle("Heroes")
            .toolbar {
                ToolbarItem {
                    Button("Add") {
                        showCreateView = true
                    }
                }
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
