import SwiftUI

struct CharacterDetailView: View {
    var character: Character

    @State private var showEditView = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.title.bold())

            Text(character.title)
                .padding(.bottom)

            Text(
                "Level \(1 + (character.experience / 100)) \(character.className)"
            )
            .font(.subheadline.bold())
            .padding(.bottom)

            Text(character.backstory)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .padding(.bottom)

            HStack {
                Text("Exp: \(character.experience)")
                    .font(.subheadline.bold())

                Spacer()

                Text("Gold: \(character.gold)")
                    .font(.subheadline.bold())
            }
            .padding(.bottom)

            ProgressView(value: Double(character.experience % 100), total: 100)
                .tint(.blue)
                .scaleEffect(x: 1, y: 4, anchor: .center)
        }
        .padding()
        .toolbar {
            Button("Edit") {
                showEditView = true
            }
        }
        .sheet(isPresented: $showEditView) {
            NavigationStack {
                CharacterDetailEditView()
                    .navigationTitle("Edit Character")
                    .toolbar {
                        ToolbarItem(placement: .cancellationAction) {
                            Button("Cancel") {
                                showEditView = false
                            }
                        }
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Save") {
                                showEditView = false
                            }
                        }
                    }
            }
        }

        CharacterQuestList(quests: character.quests)
    }
}

#Preview {
    NavigationStack {
        CharacterDetailView(character: Character.sampleCharacters.first!)
    }
}
