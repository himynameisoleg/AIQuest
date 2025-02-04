import SwiftUI

struct QuestDetailView: View {
    var quest: Quest

    var body: some View {
        VStack(alignment: .leading) {
            Text(quest.title)
                .font(.title)
                .padding(.bottom)
                .bold()

            Text(quest.desc)
                .padding(.bottom)

            Text(quest.task)
                .bold()
                .padding(.bottom)

            Section("Rewards") {
                HStack {
                    RewardChip(
                        value: quest.experienceReward,
                        label: "XP",
                        color: .blue
                    )
                    RewardChip(
                        value: quest.goldReward,
                        label: "Gold",
                        color: Color(
                            red: 212 / 255, green: 175 / 255, blue: 55 / 255)
                    )
                }
            }
        }
        .padding()

    }
}

#Preview {
    QuestDetailView(quest: Character.sampleCharacters.first!.quests.first!)
}
