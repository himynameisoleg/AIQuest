import SwiftData
import SwiftUI

struct QuestDetailView: View {
    var quest: Quest?
    @State private var isEditing = false
    @State private var isDeleting = false
    @Environment(\.modelContext) private var modelContext
    @Environment(NavigationContext.self) private var navigationContext

    var body: some View {
        if let quest {
                QuestDetailContentView(quest: quest)
                    .navigationTitle("\(quest.title)")
                    .toolbar {
                        Button {
                            isEditing = true
                        } label: {
                            Label("Edit \(quest.title)", systemImage: "pencil")
                                .help("Edit the quest")
                        }

                        Button {
                            isDeleting = true
                        } label: {
                            Label("Delete \(quest.title)", systemImage: "trash")
                                .help("Delete the quest")
                        }
                    }
                    .sheet(isPresented: $isEditing) {
                        QuestEditor(quest: quest)
                    }
                    .alert("Delete \(quest.title)?", isPresented: $isDeleting) {
                        Button("Yes, delete \(quest.title)", role: .destructive)
                        {
                            delete(quest)
                        }
                    }

            Spacer()
        } else {
            ContentUnavailableView("Select a quest", systemImage: "book")
        }
    }

    private func delete(_ quest: Quest) {
        navigationContext.selectedQuest = nil
        modelContext.delete(quest)
    }
}

private struct QuestDetailContentView: View {
    let quest: Quest

    var body: some View {
        VStack(alignment: .leading) {
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
    ModelContainerPreview(ModelContainer.sample) {
        QuestDetailView(quest: .daily)
            .environment(NavigationContext())
    }
}
