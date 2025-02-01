import ConfettiSwiftUI
import SwiftUI

struct QuestList: View {
    var character: Character
    @Environment(\.modelContext) private var modelContext
    

    var body: some View {
        List(character.quests.filter { !$0.isCompleted}) { quest in
            QuestCard(quest: quest)
                .swipeActions {
                    Button("Done!") {
                        quest.isCompleted = true
                        do {
                            try modelContext.save()
                        } catch {
                            print("failed to save context: \(error)")
                        }
                    }
                }
                .tint(.green)
        }
        .listStyle(.inset)
    }
}

#Preview {
    QuestList(character: Character.sampleCharacters.first!)
}
