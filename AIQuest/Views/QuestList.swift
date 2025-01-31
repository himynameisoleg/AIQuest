import SwiftUI

struct QuestList: View {
    var quests: [Quest]
    var body: some View {
        List(quests) { quest in
            QuestCard(quest: quest)
        }
    }
}

#Preview {
    QuestList(quests: Character.sampleCharacters.first!.quests)
}
