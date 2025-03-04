import SwiftData
import SwiftUI

struct ItemDetailView: View {
    let item: Item
    var body: some View {
        ItemDetailContentView(item: item)
    }
}

struct ItemDetailContentView: View {
    let item: Item

    @State private var selectedCharacter: Character?
    
    @Environment(\.dismiss) private var dismiss

    @Query(sort: \Character.name) private var characters: [Character]

    var body: some View {
        Text(item.name).bold()
        Text(item.desc)

        Text("Add to inventory for:")

        Form {
            Section("Purchase for: ") {
                Picker("Character", selection: $selectedCharacter) {
                    Text("Select a character").tag(nil as Character?)
                    ForEach(characters) { character in
                        Text(character.name).tag(character as Character?)
                    }
                }

                Button("Buy") {
                    buyItem()
                    dismiss()

                }
                .buttonStyle(.borderedProminent)
                .disabled(selectedCharacter == nil)
            }
        }

    }

    private func buyItem() {
        item.character = selectedCharacter
    }

}

#Preview("ItemDetailView") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemDetailView(item: Item.bootsOfStriding)
    }
}

#Preview("ItemDetailContentView") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemDetailView(item: Item.bootsOfStriding)
    }
}
