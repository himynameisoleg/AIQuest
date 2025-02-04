import SwiftUI

struct QuestList: View {
    var character: Character
    @Environment(\.modelContext) private var modelContext

    @State private var confirmationShown: Bool = false

    var body: some View {
        List(character.quests.filter { !$0.isCompleted }) { quest in
            NavigationLink {
                QuestDetailView(quest: quest)
            } label: {
                QuestRow(quest: quest)
            }
            .swipeActions {
                Button {
                    confirmationShown = true
                } label: {
                    Label("Complete", systemImage: "checkmark")
                }
                .tint(.green)

                Button {
                    // TODO: Show quest edit view
                } label: {
                    Label(
                        "Edit", systemImage: "square.and.arrow.up")
                }
                .tint(.orange)
            }
            .confirmationDialog(
                "Complete Quest?",
                isPresented: $confirmationShown
            ) {
                Button("Yes") {
                    character.experience += quest.experienceReward
                    character.gold += quest.goldReward
                    quest.isCompleted = true
                    quest.completedDate = Date()

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
