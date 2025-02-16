import Foundation

extension Character {
    static var sampleCharacters: [Character] {
        [
            Character(
                name: "Theron Dawnweaver",
                title: "The Twilight Scholar",
                habit: "Reading",
                dndClass: "Wizard",
                backstory:
                    "Born to a family of magical archivists in the floating city of Mystralis, Theron spent his youth surrounded by ancient tomes and artifacts. When shadow cultists infiltrated the city and destroyed the grand library, Theron barely escaped with a handful of precious scrolls. The loss of countless irreplaceable texts and the sacrifice of his mentor, who stayed behind to buy others time to flee, left deep scars. Now Theron wanders the realm, combining his scholarly expertise with newly developed combat skills. He seeks not just to grow stronger, but to prove that the quiet dedication of daily practice and learning can be as powerful as any grand heroic gesture.",
                motivation:
                    "After witnessing the fall of the great library of Mystralis to dark forces, Theron has dedicated his life to preserving and pursuing knowledge while building his inner strength. He believes that true power comes not just from physical prowess, but from the daily discipline of mind, body, and spirit working in harmony. Each small victory and habit mastered brings him closer to his goal of becoming worthy to help rebuild the lost library and protect its secrets.",
                experience: 40,
                gold: 125,
                quests: [
                    Quest(
                        title: "The Echoing Scrolls", task: "Read 25 minutes",
                        desc:
                            "Deep in the ruins of an abandoned monastery, Theron has discovered a collection of enchanted scrolls that whisper ancient knowledge. These rare texts, protected by a fading preservation spell, must be carefully studied before the magic dissipates. Each scroll contains fragments of lost wisdom from the great library of Mystralis, and time is of the essence. Concentrate amidst the ethereal whispers and absorb their teachings before the enchantment fades.",
                        experienceReward: 10, goldReward: 12)
                ]
            ),
            Character(
                name: "Elndra Moonshadow",
                title: "The Eldritch Enigma",
                habit: "Exercise regularly",
                dndClass: "Artificer",
                backstory: "Backstory goes here.",
                motivation: "Motivation goes here.",
                experience: 25,
                gold: 3,
                quests: []
            ),
        ]
    }
}
