//
//  CharacterDetail.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import SwiftUI

struct CharacterDetail: View {
    var character: Character
    
    private var characterClass: CharacterClass? {
        CharacterClass(rawValue: character.className)
    }

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
                .tint(characterClass?.attributes.color)
                .scaleEffect(x: 1, y: 4, anchor: .center)
        }
        .padding()

        CharacterQuestList(quests: character.quests)
    }
}

#Preview {
    CharacterDetail(character: characters[0])
}
