import SwiftData
import SwiftUI

struct CharacterList: View {
    @Query var characters: [Character]

    @Environment(\.modelContext) private var modelContext

    @State private var showCreateView = false

    var body: some View {
        NavigationSplitView {
            List(characters) { character in
                NavigationLink {
                    CharacterDetailView(character: character)
                } label: {
                    CharacterRow(character: character)
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
            .sheet(isPresented: $showCreateView) {
                NavigationStack {
                    CharacterCreateView(showCreateView: $showCreateView)
                        .navigationTitle("Create Character")
                }
            }

        } detail: {
            Text("Select your Hero")
        }
    }
}

#Preview {
    CharacterList()
        .modelContainer(previewContainer)
}
