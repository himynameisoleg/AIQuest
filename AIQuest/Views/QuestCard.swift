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
        QuestCard(quest: Character.sampleCharacters.first!.quests.first!)
    }
}
