import SwiftUI

struct CharacterDetailView: View {
    var character: Character

    @Binding var showEditView: Bool
    @State private var isExpanded: Bool = false

    var body: some View {
        VStack(alignment: .leading) {
            Text(character.name)
                .font(.title.bold())

            Text(character.title)
                .padding(.bottom)

            //        TODO: simplify class selector to avoid this weird NSManagedObject bug
            Text(
                "Level \(1 + (character.experience / 100)) \(character.className)"
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

            QuestList(character: character)
        }
        .padding()

        //        .toolbar {
        //            Button("Edit") {
        //                showEditView = true
        //            }
        //        }
        //        .sheet(isPresented: $showEditView) {
        //            NavigationStack {
        //                CharacterEditView(
        //                    character: character, showEditView: $showEditView
        //                )
        //                .navigationTitle("Edit Character")
        //            }
        //        }

    }
}

#Preview {
    @Previewable @State var visible: Bool = false
    NavigationStack {
        CharacterDetailView(
            character: Character.sampleCharacters.first!, showEditView: $visible
        )
    }
}
