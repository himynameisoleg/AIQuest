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
                The habit is "\(habit)".

                Generate only one character. The response data should only be enclosed in 1 set of curly braces {}. Do not respond with markdown.
                The response must be parsable, valid JSON object.
                Ensure proper JSON escaping for all strings, e.g.:
                {
                  "name": "O'Reilly",  // Correctly escaped single quote
                  "message": "He said, \"Hello!\"", // Correctly escaped double quotes
                  "path": "C:\\Users\\admin" // Correctly escaped backslash
                }

                The response JSON should contain the following fields:
                name: String
                title: String,
                backstory: String
                motivation: String
                """
        )
    }

    static func createQuestPrompt(
        character: Character, task: String, difficulty: String
    ) -> Prompt {
        return Prompt(
            message: """
                Using the the character details below, generate a quest for the following task: \(task). 
                Generate quest details including title, narratives, experience reward and gold reward. 
                The quest should correspond with this task and be on theme with the overal character habit.
                The experience and gold reward should be based on the difficulty classifier of "\(difficulty)".

                The quest narratives should follow a hero's journey story arc and be about 3000 words long. 
                The theme is medeival fantasy (think Lord of the Rings, the Witcher, Dungeons & Dragons and Skyrim).
                Break the story down into 7 stages, 1 being the "call to adventure" and 7 is the "return".
                Each of the 7 of the narrative array should be a part of the heros journey story arc. 
                Generate the narrative as if it were a quest that the character is setting off on.
                Start the story off by setting the scene give a little backstory and explain how they came to be in their situation.  

                Keep the xp and gold reward varied based on this criteria:
                Side Quest = around 10 xp, 10 gold 
                Heroic = around 30 xp, 30 gold
                Epic = around 50xp, 50 gold + roll d20 for additional gold

                Here are the character's details:
                Habit: \(character.habit)
                Name: \(character.name)
                Backstory: \(character.backstory)
                Motivation: \(character.motivation)

                Generate only one quest. 
                The response data should only be enclosed in 1 set of curly braces {}. 
                Do not respond with markdown. 
                Dont forget the close the brackets in the narrative field.
                The response must be parsable, valid JSON object.
                Ensure proper JSON escaping for all strings, e.g.:
                {
                  "name": "O'Reilly",  // Correctly escaped single quote
                  "message": "He said, \"Hello!\"", // Correctly escaped double quotes
                  "path": "C:\\Users\\admin" // Correctly escaped backslash
                }

                The response JSON should contain the following fields:
                title: String
                narrative: [String]
                experienceReward: Int
                goldReward: Int
                
                example response:
                {
                    "title": "The Lost Tome of Tenaria",
                    "narrative": [
                        "You sit in the dimly lit library, surrounded by...",
                        "Eira, I've been waiting for you. I found a cryptic message...",
                        "Drink it if you need it. But remember, the forest has its own secrets...",
                        "You set off towards the forgotten...",
                        "When suddenly...",
                        "As you read the final text, a surge of knowledge...",
                        "You feel a sense of balance return to..."
                    ],
                    "experienceReward": 11,
                    "goldReward" 9
                }
                
                """
        )
    }
}
