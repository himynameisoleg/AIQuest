import Foundation
import SwiftData

extension Character {
    static let wizard = Character(
        name: "Gandalf",
        title: "The Grey",
        habit: "Reading",
        dndClass: "Wizard",
        backstory:
            "Born to a family of magical archivists in the floating city of Mystralis, Theron spent his youth surrounded by ancient tomes and artifacts. When shadow cultists infiltrated the city and destroyed the grand library, Theron barely escaped with a handful of precious scrolls. The loss of countless irreplaceable texts and the sacrifice of his mentor, who stayed behind to buy others time to flee, left deep scars. Now Theron wanders the realm, combining his scholarly expertise with newly developed combat skills. He seeks not just to grow stronger, but to prove that the quiet dedication of daily practice and learning can be as powerful as any grand heroic gesture.",
        motivation:
            "After witnessing the fall of the great library of Mystralis to dark forces, Theron has dedicated his life to preserving and pursuing knowledge while building his inner strength. He believes that true power comes not just from physical prowess, but from the daily discipline of mind, body, and spirit working in harmony. Each small victory and habit mastered brings him closer to his goal of becoming worthy to help rebuild the lost library and protect its secrets.",
        experience: 40,
        gold: 125
    )
    static let artificer = Character(
        name: "Torwyn Cogspark",
        title: "The Inventor of Shadows",
        habit: "Side Projects",
        dndClass: "Artificer",
        backstory:
            "Torwyn is a genius inventor who crafts wondrous devices to aid the realm. Each project brings him closer to completing the legendary 'Device of Eternity,' a machine that will change the world.",
        motivation:
            "Torwyn’s motivation stems from his insatiable curiosity and an unyielding drive to innovate. Having grown up in a humble workshop on the outskirts of the kingdom, he watched his family struggle to make ends meet with outdated tools and machinery. Torwyn vowed to create inventions that would transform lives and ensure no one would endure the hardships he witnessed. However, beneath his noble aspirations lies a subtle fear: that he will be forgotten, his creations lost to time. This drives him to obsess over perfecting his designs, sometimes at the cost of his own well-being. Torwyn is determined to leave behind a legacy so profound that his name will echo in the halls of invention for generations.",
        experience: 10,
        gold: 20
    )

    static func insertSampleData(modelContext: ModelContext) {
        // Add the Character to model
        modelContext.insert(wizard)
        modelContext.insert(artificer)

        // Add the quest to the model context.
        modelContext.insert(Quest.daily)

       // Add items to the shop
        modelContext.insert(Item.bootsOfStriding)
        modelContext.insert(Item.tomeOfArcaneKnowledge)

        // Set character assigned to quest
        Quest.daily.character = wizard


    }

    static func reloadSampleData(modelContext: ModelContext) {
        do {
            try modelContext.delete(model: Character.self)
            insertSampleData(modelContext: modelContext)
        } catch {
            fatalError(error.localizedDescription)
        }
    }
}
