import SwiftUI

struct CharacterRow: View {
    var character: Character

    var body: some View {
        HStack {
            Text(character.icon)
            VStack(alignment: .leading) {

                Text(character.name)
                Text(character.habit)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            if character.quests.filter({!$0.isCompleted}).count > 0 {
                Circle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(
                        mapClassToColor(dndClass: character.dndClass)
                    )
            }
        }
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CharacterRow(character: Character.sampleCharacters.first!)
    }
}
