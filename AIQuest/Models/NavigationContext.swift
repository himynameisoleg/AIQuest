import SwiftUI

@Observable
class NavigationContext {
    var selectedCharacterName: String?
    var selectedQuest: Quest?
    var columnVisibility: NavigationSplitViewVisibility

    var sidebarTitle = "Heroes"

    var contentListTitle: String {
        if let selectedCharacterName {
            selectedCharacterName
        } else {
            ""
        }
    }

    init(selectedCharacterName: String? = nil,
         selectedQuest: Quest? = nil,
         columnVisibility: NavigationSplitViewVisibility = .automatic) {
        self.selectedCharacterName = selectedCharacterName
        self.selectedQuest = selectedQuest
        self.columnVisibility = columnVisibility
    }
}

