import SwiftUI

@Observable
class NavigationContext {
    var selectedCharacter: Character?
    var selectedQuest: Quest?
    var columnVisibility: NavigationSplitViewVisibility

    var sidebarTitle = "Heroes"

    init(
        selectedCharacter: Character? = nil,
        selectedQuest: Quest? = nil,
        columnVisibility: NavigationSplitViewVisibility = .automatic
    ) {
        self.selectedCharacter = selectedCharacter
        self.selectedQuest = selectedQuest
        self.columnVisibility = columnVisibility
    }
}
