import SwiftUI

struct QuestList: View {
    var character: Character
    @Environment(\.modelContext) private var modelContext
    
    @State private var confirmationShown: Bool = false
    
    var body: some View {
        List(character.quests.filter { !$0.isCompleted }) { quest in
            QuestCard(quest: quest)
                .swipeActions {
                    Button("Complete Quest") {
                        confirmationShown = true
                    }
                }
                .tint(.green)
                .confirmationDialog(
                    "Complete Quest?",
                    isPresented: $confirmationShown
                ) {
                    Button("Yes") {
                        character.experience += quest.experienceReward
                        character.gold += quest.goldReward
                        quest.isCompleted = true
                        
                        do {
                            try modelContext.save()
                        } catch {
                            print("failed to save context: \(error)")
                        }
                    }
                }
        }
        .listStyle(.inset)
    }
}

#Preview {
    QuestList(character: Character.sampleCharacters.first!)
}
