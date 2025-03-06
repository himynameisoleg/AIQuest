import SwiftData
import SwiftUI

struct CharacterDetailView: View {
    let character: Character
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.title)
                .font(.title3.bold())
                .padding(.bottom)

            Text(
                "Level \(1 + (character.experience / 100)) \(character.dndClass)"
            )
            .font(.subheadline.bold())

            Text("Habit: \(character.habit)")
                .font(.subheadline.bold())
                .padding(.bottom)


            ScrollView {
                Text(character.backstory)
                    .font(.subheadline)
                    .font(.caption)
            }

            HStack {
                Text("Exp: \(character.experience)")
                    .font(.subheadline.bold())

                Spacer()

                Text("Gold: \(character.gold)")
                    .font(.subheadline.bold())
            }
            .padding(.vertical)

            ProgressView(value: Double(character.experience % 100), total: 100)
                .tint(.blue)
                .scaleEffect(x: 1, y: 4, anchor: .center)
                .padding(.bottom)
                .progressViewStyle(
                    LinearProgressViewStyle(
                        tint: mapClassToColor(dndClass: character.dndClass)
                    )
                )
        }
    }
}

#Preview("CharacterDetailView") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            CharacterDetailView(character: Character.wizard)
                .environment(NavigationContext())
        }
    }
}
