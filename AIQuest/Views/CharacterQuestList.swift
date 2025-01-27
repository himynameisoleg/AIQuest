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
    CharacterQuestList(quests: Character.sampleCharacters.first!.quests)
}
