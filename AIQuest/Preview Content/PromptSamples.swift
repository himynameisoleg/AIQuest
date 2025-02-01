import Foundation

private let c = Character.sampleCharacters.first!

extension Prompt {
    static var sampleCharacterCreatePrompt: Prompt {
        Prompt(
            message: """
I want to gamify a goal or habit using storytelling and daily quests. The theme is medeival and high-fantasy (similar to Lord of the Rings, The Witcher, Skyrim, Dungeons & Dragons). 
Generate my character details including their name, title, motivation and backstory. 
Respond in JSON format with name, title, motivation, backstory. 
The backstory should be around 150 words or less. 
The motivation should be around 100 words or less. 
Example: 
{
    "name":"\(c.name)",
    "title":"\(c.title)",
    "backstory":"\(c.backstory)",
    "motivation":"\(c.motivation)"
}
"""
        )
    }
    
    static var sampleQuestCreatePrompt: Prompt {
        Prompt(
            message: """
Using the the character details below, generate a daily quest for their habit. 
The task should correspond with this habit. 
The experience and gold reward should be around 10 but keep it varied based on the difficulty of the task.
Build a story based onpon the previous quest.
Example:
{
    "title":"\(c.quests.first!.title)",
    "task":"\(c.quests.first!.task)",
    "desc":"\(c.quests.first!.desc)",
    "experienceReward":\(c.quests.first!.experienceReward),
    "goldReward":\(c.quests.first!.goldReward)
}

Character Details:

"""
            )
    }
    
}
