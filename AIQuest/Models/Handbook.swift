import SwiftUI
import Foundation

struct Handbook {
    static let introduction = """
    Welcome, traveler, to the grand chronicle of self-discipline and might. This is no ordinary realm, but a world where your ambitions take form, where every habit forged in the fires of resolve becomes a hero in its own right. The path ahead is perilous, yet rewarding beyond measure. Take heed of this tome, for within its pages lies the key to your ascension.
    """

    static let chapters: [Chapter] = [
        Chapter(
            title: "Summoning the Heroes",
            subtitle: "Character Creation",
            content: """
            Every great legend begins with a hero. In this realm, your habits are the warriors, mages, and rogues of destiny. To summon forth a champion, venture to the *Heroes Screen* and inscribe their name upon the annals of time.
            
            Need guidance from the arcane? Invoke the AI Oracle to conjure a hero worthy of your quest.
            """
        ),
        Chapter(
            title: "The Call to Adventure",
            subtitle: "Quest Creation",
            content: """
            A hero without purpose is but a leaf in the wind. To grant them direction, embark upon a **Quest**. These sacred trials transform routine into ritual, forging discipline into destiny.
            
            Quests not only challenge your champions but also bring forth the bounties of experience and gold—rewards for those who tread the path of perseverance.
            """
        ),
        Chapter(
            title: "The Mark of Mastery",
            subtitle: "Leveling Up",
            content: """
            With every step, a hero grows stronger. With every challenge overcome, they inch closer to renown. Experience points (XP) fuel this ascension, lifting your champions from obscurity into the annals of legend.
            
            **Side Quest** – A steady march forward.
            **Heroic Quest** – A trial of valor, fit for those who seek greater rewards.
            **Epic Quest** – A test of the mightiest, reserved for those who wish to carve their names in stone.
            
            At the sacred threshold of **100 XP**, a hero shall ascend, their power rising, their legend growing.
            """
        ),
        Chapter(
            title: "The Bounty of Champions",
            subtitle: "Rewards",
            content: """
            No warrior fights for glory alone. The spoils of battle await those who prove their mettle. The *Market* stands as a haven for heroes who seek the fruits of their labor.
            
            Gold amassed from victorious quests may be exchanged for mighty relics, rare artifacts, or treasured boons. As your heroes rise in strength, so too shall their armory, rewarding them with well-earned luxuries and tokens of triumph.
            """
        )
    ]

    struct Chapter {
        let title: String
        let subtitle: String
        let content: LocalizedStringKey // markdown
    }
}
