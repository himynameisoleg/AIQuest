import Foundation

private let c = Character.sampleCharacters.first!

extension Prompt {
    static func createCharacterPrompt(habit: String) -> Prompt {
        return Prompt(
            message: """
I want to gamify a goal or habit using storytelling and daily quests. The theme is medeival and high-fantasy (similar to Lord of the Rings, The Witcher, Skyrim, Dungeons & Dragons). 
Generate my character details including their name, title, motivation and backstory. 
Respond in JSON format with name, title, motivation, backstory. 
The backstory should be around 150 words or less. 
The motivation should be around 100 words or less. 
Example: 
{’
    "name":"\(c.name)",
    "title":"\(c.title)",
    "backstory":"\(c.backstory)",
    "motivation":"\(c.motivation)"
}

The habit is "\(habit)".
"""
        )
    }
    
    static func createQuestPrompt(character: Character) -> Prompt {
        return Prompt(
            message: """
Using the the character details below, generate a daily quest for their habit - \(character.habit). 
Generate my quest details including title, task, description, experiance reward and gold reward. 
The task should correspond with this habit and should be a real world activity hat one can accomplish on a daily basis.
The experience and gold reward should be around 10 but keep it varied based on the difficulty or duration of the task.

Here are the character's details:
Name: \(character.name)
Backstory: \(character.backstory)
Habit: \(character.habit)


Generate only one quest. The response data should only be enclosed in 1 set of curly braces {}.
 The response should follow this structure in this example:
{
    "title":"\(c.quests.first!.title)",
    "task":"\(c.quests.first!.task)",
    "desc":"\(c.quests.first!.desc)",
    "experienceReward":\(c.quests.first!.experienceReward),
    "goldReward":\(c.quests.first!.goldReward)
}
"""
            )
    }
    
}
