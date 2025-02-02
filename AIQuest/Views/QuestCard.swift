import SwiftUI

struct QuestCard: View {
    var quest: Quest
    
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(quest.title)
                .font(.title)
            Text(quest.task)
                .font(.subheadline)
            
            Text(quest.desc)
                .padding(.top)
                .lineLimit(isExpanded ? nil : 5)
            
            if quest.desc.count > 200 {
                Button(isExpanded ? "Read Less" : "Read More") {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }
                .foregroundColor(.blue)
            }
            
            HStack {
                RewardChip(
                    value: quest.experienceReward,
                    label: "XP",
                    color: .blue
                )
                Spacer()
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
    QuestCard(quest: Character.sampleCharacters.first!.quests.first!)
}
