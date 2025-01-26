//
//  QuestCard.swift
//  AIQuest
//
//  Created by op on 1/19/25.
//

import SwiftUI

struct QuestCard: View {
    var quest: Quest
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(quest.title)
                .font(.headline)
            Text(quest.task)
            
            HStack {
                Text("\(quest.experienceReward) XP")
                Text("\(quest.goldReward) Gold")
            }

        }
    }
}

#Preview {
    Group {
        QuestCard(quest: characters[0].quests[0])
        QuestCard(quest: characters[0].quests[1])
    }
}
