import SwiftUI
import SwiftData

struct ThreeColumnContentView: View {
    @Environment(NavigationContext.self) private var navigationContext
    @Environment(\.modelContext) private var modelContext

    var body: some View {
        @Bindable var navigationContext = navigationContext
        NavigationSplitView(columnVisibility: $navigationContext.columnVisibility) {
            CharacterListView()
//                .navigationTitle(navigationContext.sidebarTitle)
        } content: {
//            QuestListView(characterName: navigationContext.selectedCharacterName)
//                .navigationTitle(navigationContext.contentListTitle)
        } detail: {
            NavigationStack {
//                QuestDetailView(quest: navigationContext.selectedQuest)
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
