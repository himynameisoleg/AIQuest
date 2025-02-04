import SwiftUI

struct QuestRow: View {
    var quest: Quest
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(quest.title)
                .font(.headline)
            Text(quest.task)
                .font(.subheadline)
                .padding(.bottom, 1)
            
            HStack {
                RewardChip(
                    value: quest.experienceReward,
                    label: "XP",
                    color: .blue
                )
                RewardChip(
                    value: quest.goldReward,
                    label: "Gold",
                    color: Color(red: 212/255, green: 175/255, blue: 55/255)
                )
            }
            .padding(.top)
        }
    }
}

#Preview {
    QuestRow(quest: Character.sampleCharacters.first!.quests.first!)
}
