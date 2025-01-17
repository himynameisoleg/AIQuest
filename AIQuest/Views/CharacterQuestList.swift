//
//  CharacterQuestList.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import SwiftUI

struct CharacterQuestList: View {
    var quests: [Quest]
    var body: some View {
        List(quests) { quest in
            VStack(alignment: .leading) {
                Text(quest.title)
                    .font(.title.bold())
                Text(quest.description)
                
                Spacer()
                
                Text(
                    "Reward: \(quest.experienceReward) XP | \(quest.goldReward) Gold"
                )

            }
            .padding()

        }
    }
}

#Preview {
    CharacterQuestList(quests: characters[0].quests)
}
