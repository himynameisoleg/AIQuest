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
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(.blue)
        }
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CharacterRow(character: Character.sampleCharacters.first!)
    }
}
