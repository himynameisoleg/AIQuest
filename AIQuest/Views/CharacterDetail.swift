//
//  CharacterDetail.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import SwiftUI

struct CharacterDetail: View {
    var character: Character

    var body: some View {
            VStack(alignment: .leading) {
                Text(character.name)
                    .font(.title.bold())
                
                Text(character.title)
                
                Text(character.backstory)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            .padding()
        
            CharacterQuestList(quests: character.quests)
    }
}

#Preview {
    CharacterDetail(character: characters[0])
}
