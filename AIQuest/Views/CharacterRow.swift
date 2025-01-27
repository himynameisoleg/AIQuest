import SwiftUI

struct CharacterRow: View {
    var character: Character

    var body: some View {
        HStack {
//            TODO: the optionals are always defaulting on boot.
//            Maybe need to fetch data before rendering this View.
            Text(
                "\(CharacterClass(rawValue: character.className)?.attributes.icon ?? "👻")"
            )
            VStack(alignment: .leading) {

                Text("\(character.name)")
                Text("\(character.habit)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(
                    CharacterClass(rawValue: character.className)?.attributes
                        .color ?? .gray)
        }
    }

}

#Preview(traits: .sizeThatFitsLayout) {
    Group {
        CharacterRow(character: Character.sampleCharacters.first!)
    }
}
