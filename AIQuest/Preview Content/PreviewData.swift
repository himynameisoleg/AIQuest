import SwiftData

@MainActor
let previewContainer: ModelContainer = {
    do {
        let container = try ModelContainer(
            for: Character.self,
            configurations: .init(isStoredInMemoryOnly: true))

        for character in Character.sampleCharacters {
            container.mainContext.insert(character)
        }

        return container
    } catch {
        fatalError("Failed to create container.")
    }
}()
