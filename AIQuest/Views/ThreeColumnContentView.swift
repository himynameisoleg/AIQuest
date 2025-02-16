import SwiftUI
import SwiftData

struct ThreeColumnContentView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            CharacterListView()
                .navigationTitle(navigationContext.sidebarTitle)
        } content: {
            QuestListView(character: navigationContext.selectedCharacter)
                .navigationTitle(navigationContext.selectedCharacter?.name ?? "")
        } detail: {
            NavigationStack {
                QuestDetailView(quest: navigationContext.selectedQuest)
            }
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ThreeColumnContentView()
            .environment(NavigationContext())
    }
}
