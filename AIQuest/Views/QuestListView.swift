import SwiftUI
import SwiftData

struct QuestListView: View {
    let characterName: String?

    var body: some View {
        if let characterName {
            QuestList(characterName: characterName)
        } else {
            ContentUnavailableView("Select a hero", systemImage: "sidebar.left")
        }

        //        List(character.quests.filter { !$0.isCompleted }) { quest in
        //            NavigationLink {
        //                QuestDetailView(quest: quest)
        //            } label: {
        //                QuestRow(quest: quest)
        //            }
        //            .swipeActions {
        //                Button {
        //                    confirmationShown = true
        //                } label: {
        //                    Label("Complete", systemImage: "checkmark")
        //                }
        //                .tint(.green)
        //
        //                Button {
        //                    // TODO: Show quest edit view
        //                } label: {
        //                    Label(
        //                        "Edit", systemImage: "square.and.arrow.up")
        //                }
        //                .tint(.orange)
        //            }
        //            .confirmationDialog(
        //                "Complete Quest?",
        //                isPresented: $confirmationShown
        //            ) {
        //                Button("Yes") {
        //                    character.experience += quest.experienceReward
        //                    character.gold += quest.goldReward
        //                    quest.isCompleted = true
        //                    quest.completedDate = Date()
        //
        //                    do {
        //                        try modelContext.save()
        //                    } catch {
        //                        print("failed to save context: \(error)")
        //                    }
        //                }
        //            }
        //        }
        //        .listStyle(.inset)
    }
}

private struct QuestList: View {
    let characterName: String
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Quest.title) private var quests: [Quest]
    @State private var isEditorPresented = false

    init(characterName: String) {
        self.characterName = characterName
        let predicate = #Predicate<Quest> { quest in
            quest.character?.name == characterName
        }
        _quests = Query(filter: predicate, sort: \Quest.title)
    }

    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedQuest) {
            ForEach(quests) { quest in
                NavigationLink(quest.title, value: quest)
            }
            .onDelete(perform: removeQuests)
        }
        .sheet(isPresented: $isEditorPresented) {
            QuestEditor(quest: nil)
        }
        .overlay {
            if quests.isEmpty {
                ContentUnavailableView {
                    Label("No quests for this character", systemImage: "person.circle")
                } description: {
                    AddQuestButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddQuestButton(isActive: $isEditorPresented)
            }
        }
    }

    private func removeQuests(at indexSet: IndexSet) {
        for index in indexSet {
            let questToDelete = quests[index]
            if navigationContext.selectedQuest?.persistentModelID == questToDelete.persistentModelID {
                navigationContext.selectedQuest = nil
            }
            modelContext.delete(questToDelete)
        }
    }
}

private struct AddQuestButton: View {
    @Binding var isActive: Bool

    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add a Quest", systemImage: "plus")
                .help("Add a Quest")
        }
    }
}

#Preview("QuestListView") {
    ModelContainerPreview(ModelContainer.sample) {
        NavigationStack {
            QuestListView(characterName: Character.wizard.name)
                .environment(NavigationContext())
        }
    }
}

#Preview("No selected category") {
    ModelContainerPreview(ModelContainer.sample) {
        QuestListView(characterName: nil)
    }
}

#Preview("No Quests") {
    ModelContainerPreview(ModelContainer.sample) {
        QuestList(characterName: Character.artificer.name)
            .environment(NavigationContext())
    }
}

#Preview("AddQuestButton") {
    AddQuestButton(isActive: .constant(false))
}
