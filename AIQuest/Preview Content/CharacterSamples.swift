import Foundation

extension Character {
    static var sampleCharacters: [Character] {
        [
            Character(
                name: "John Doe",
                title: "The Adventurer",
                habit: "I am a disciplined and hardworking individual.",
                className: "Wizard",
                backstory: "Backstory goes here.",
                motivation: "Motivation goes here.",
                experience: 40,
                gold: 125,
                quests: [
                    Quest(
                        title: "Sample Quest", task: "Do great stuff!",
                        description: "Description goes here.",
                        experienceReward: 10, goldReward: 10)
                ]
            )
        ]
    }
}
