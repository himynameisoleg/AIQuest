import Foundation

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
    "name":"Theron Dawnweaver",
    "title":"The Twilight Scholar",
    "motivation":"After witnessing the fall of the great library of Mystralis to dark forces, Theron has dedicated his life to preserving and pursuing knowledge while building his inner strength. He believes that true power comes not just from physical prowess, but from the daily discipline of mind, body, and spirit working in harmony. Each small victory and habit mastered brings him closer to his goal of becoming worthy to help rebuild the lost library and protect its secrets.",
    "backstory":"Born to a family of magical archivists in the floating city of Mystralis, Theron spent his youth surrounded by ancient tomes and artifacts. When shadow cultists infiltrated the city and destroyed the grand library, Theron barely escaped with a handful of precious scrolls. The loss of countless irreplaceable texts and the sacrifice of his mentor, who stayed behind to buy others time to flee, left deep scars. Now Theron wanders the realm, combining his scholarly expertise with newly developed combat skills. He seeks not just to grow stronger, but to prove that the quiet dedication of daily practice and learning can be as powerful as any grand heroic gesture."
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
    "title":"The Echoing Scrolls",
    "task":"Read 25 minutes",
    "description":"Deep in the ruins of an abandoned monastery, Theron has discovered a collection of enchanted scrolls that whisper ancient knowledge. These rare texts, protected by a fading preservation spell, must be carefully studied before the magic dissipates. Each scroll contains fragments of lost wisdom from the great library of Mystralis, and time is of the essence. Concentrate amidst the ethereal whispers and absorb their teachings before the enchantment fades.",
    "experienceReward":9,
    "goldReward":12
}

Character Details:

"""
            )
    }
    
}
