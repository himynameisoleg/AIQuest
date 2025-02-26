import SwiftData
import SwiftUI

struct QuestListView: View {
    var character: Character?

    var body: some View {
        if let character {
            CharacterDetailView(character: character)
                .padding(.horizontal)
            QuestList(character: character)
        } else {
            ContentUnavailableView("Select a hero", systemImage: "sidebar.left")
        }
    }
}

private struct QuestList: View {
    let character: Character
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Quest.title) private var quests: [Quest]
    @State private var isEditorPresented = false
    @State private var confirmationShown = false
    @State private var isLoading: Bool = true

    @State private var title = ""
    @State private var task = ""
    @State private var desc: [String] = []
    @State private var experienceReward: Int = 10
    @State private var goldReward: Int = 10

    init(character: Character) {
        self.character = character
        let characterName = character.name
        let predicate = #Predicate<Quest> { quest in
            quest.character?.name == characterName
        }
        _quests = Query(filter: predicate, sort: \Quest.title)
    }

    var body: some View {
        @Bindable var navigationContext = navigationContext
        List(selection: $navigationContext.selectedQuest) {
            ForEach(quests.filter { !$0.isCompleted }) { quest in
                NavigationLink(value: quest) {
                    VStack(alignment: .leading) {
                        Text(quest.title)
                        Text(quest.task).font(.caption)
                        HStack {
                            Text("\(quest.difficulty)").font(.caption)
                            Spacer()
                            Text("\(quest.experienceReward) XP").font(.caption)
                            Text("\(quest.goldReward) Gold").font(.caption)
                        }

                        ProgressView(
                            value: Double(quest.progressionStage), total: 7
                        )
                        .tint(.blue)
                        .progressViewStyle(LinearProgressViewStyle())

                    }
                }
                .swipeActions {
                    Button {
                        confirmationShown = true
                    } label: {
                        Label("Complete", systemImage: "checkmark")
                    }
                    .tint(.green)
                }
                .confirmationDialog(
                    "Complete Quest?",
                    isPresented: $confirmationShown
                ) {
                    Button("Continue the Journey") {
                        character.experience += quest.experienceReward
                        character.gold += quest.goldReward
                        quest.progressionStage += 1
                        quest.completedDate = Date()

                        if quest.progressionStage > 6 {
                            quest.isCompleted = true
                        }
                    }
                }
            }
        }
        .sheet(isPresented: $isEditorPresented) {
            QuestEditor(quest: nil)
        }
        .overlay {
            if quests.filter({ !$0.isCompleted }).isEmpty {
                ContentUnavailableView {
                    Label(
                        "Rest well, Adventurer.\n More quests await.",
                        systemImage: "book")
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
            if navigationContext.selectedQuest?.persistentModelID
                == questToDelete.persistentModelID
            {
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
            QuestListView(character: Character.wizard)
                .environment(NavigationContext())
        }
    }
}

#Preview("No selected category") {
    ModelContainerPreview(ModelContainer.sample) {
        QuestListView(character: nil)
    }
}

#Preview("No Quests") {
    ModelContainerPreview(ModelContainer.sample) {
        QuestList(character: Character.artificer)
            .environment(NavigationContext())
    }
}

#Preview("AddQuestButton") {
    AddQuestButton(isActive: .constant(false))
}
