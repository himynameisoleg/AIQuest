import SwiftData
import SwiftUI

struct CharacterList: View {
    @Query var characters: [Character]

    @Environment(\.modelContext) private var modelContext

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
                        modelContext.insert(Character.sampleCharacters.first!)
                    }
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
