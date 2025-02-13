import SwiftUI

@main
struct AIQuestApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Character.self)
    }

    init() {
        // debuggin
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
