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
            QuestCard(quest: quest)
        }
    }
}

#Preview {
    CharacterQuestList(quests: characters[0].quests)
}
