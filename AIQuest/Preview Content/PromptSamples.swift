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
    
    static func createQuestPrompt(character: Character, task: String, difficulty: String) -> Prompt {
        return Prompt(
            message: """
Using the the character details below, generate a daily quest for the following task: \(task). 
Generate my quest details including title, description, experience reward and gold reward. 
The quest should correspond with this task and be on theme with the overal character habit.
The experience and gold reward should be based on the difficulty classifier of "\(difficulty)".

Keep the xp and gold reward varied based on this criteria:
Side Quest = around 10 xp, 10 gold 
Heroic = around 30 xp, 30 gold
Epic = around 50xp, 50 gold + roll d20 for additional gold

Here are the character's details:
Habit: \(character.habit)
Name: \(character.name)
Backstory: \(character.backstory)
Motivation: \(character.motivation)

Generate the quest as if the character is interacting with an NPC in a game. Set the scene, describe what the NPC wants and give a little backstory. 

Generate only one quest. The response data should only be enclosed in 1 set of curly braces {}.
 The response should follow this structure in this example:
{
    "title":"\(c.quests.first!.title)",
    "desc":"\(c.quests.first!.desc)",
    "experienceReward":\(c.quests.first!.experienceReward),
    "goldReward":\(c.quests.first!.goldReward)
}
"""
            )
    }
    
}
