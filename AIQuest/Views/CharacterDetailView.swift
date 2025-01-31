import SwiftUI

struct CharacterDetailView: View {
    var character: Character

    @Binding var showEditView: Bool

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
                CharacterEditView(
                    character: character, showEditView: $showEditView
                )
                .navigationTitle("Edit Character")
            }
        }

        CharacterQuestList(quests: character.quests)
    }
}

#Preview {
    @Previewable @State var visible: Bool = true
    NavigationStack {
        CharacterDetailView(
            character: Character.sampleCharacters.first!, showEditView: $visible
        )
    }
}
