import SwiftUI

struct CharacterDetailView: View {
    var character: Character
    @Environment(\.modelContext) private var modelContext
    
    @State private var showQuestCreateView: Bool = false

    @State private var isExpanded: Bool = false
    @State private var isLoading: Bool = false
    @State private var resultText: String = ""

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.title.bold())

            Text(character.title)
                .padding(.bottom)

            // TODO: simplify class selector to avoid this weird NSManagedObject bug
            Text(
                "Level \(1 + (character.experience / 100))"
            )
            .font(.subheadline.bold())
            .padding(.bottom)

            Text(character.backstory)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(isExpanded ? nil : 5)

            if character.backstory.count > 200 {
                Button(isExpanded ? "Read Less" : "Read More") {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .font(.caption)
                .foregroundColor(.blue)
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
                .progressViewStyle(LinearProgressViewStyle())

            Text(resultText)

//            QuestListView(characterName: "hello")

        }
        .padding()
        .toolbar {
            Button("New Quest") {
                showQuestCreateView = true
            }
        }
        .sheet(isPresented: $showQuestCreateView) {
            NavigationStack {
                QuestCreateView(
                    character: character, showQuestCreateView: $showQuestCreateView
                )
                .navigationTitle("New Quest")
            }
        }
    }
}

#Preview {
    @Previewable @State var visible: Bool = false
    NavigationStack {
        CharacterDetailView(character: Character.sampleCharacters[0])
    }
}
