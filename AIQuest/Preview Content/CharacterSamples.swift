import Foundation

extension Character {
    static var sampleCharacters: [Character] {
        [
            Character(
                name: "Torwyn Cogspark",
                title: "The Tinkerig Expert",
                habit: "Project",
                className: "Artificer",
                backstory: "Here is my backstory",
                motivation: "And my motivations",
                experience: 40,
                gold: 125,
                quests: [
                    Quest(
                        title: "Sample Quest", task: "Do great stuff!",
                        description: "Description goes here.",
                        experienceReward: 10, goldReward: 10)
                ]
            ),
            Character(
                name: "Elndra Moonshadow",
                title: "The Eldritch Enigma",
                habit: "Reading",
                className: "Wizard",
                backstory: "Backstory goes here.",
                motivation: "Motivation goes here.",
                experience: 569,
                gold: 3003,
                quests: [
                    Quest(
                        title: "Master Quest", task: "Do it!",
                        description: "Description goes here.",
                        experienceReward: 9, goldReward: 12)
                ]
            ),
        ]
    }
}
