//
//  CharacterClass.swift
//  AIQuest
//
//  Created by op on 1/17/25.
//
import SwiftUI

struct ClassAttributes {
    let icon: String
    let color: Color
}

enum CharacterClass: String, CaseIterable {
    case artificer = "Artificer"
    case druid = "Druid"
    case paladin = "Paladin"
    case rogue = "Rogue"
    case wizard = "Wizard"
//    case fighter = "Fighter"
//    case cleric = "Cleric"
//    case ranger = "Ranger"
//    case bard = "Bard"
//    case barbarian = "Barbarian"
//    case monk = "Monk"
//    case warlock = "Warlock"
//    case sorcerer = "Sorcerer"
    
    var attributes: ClassAttributes {
        switch self {
        case .artificer:
            return ClassAttributes(
                icon: "⚙️",
                color: .brown
            )
        case .druid:
            return ClassAttributes(
                icon: "🧝‍♀️",
                color: .green
            )
        case .paladin:
            return ClassAttributes(
                icon: "⚔️",
                color: .red
            )
        case .rogue:
            return ClassAttributes(
                icon: "🗡️",
                color: .purple
            )
        case .wizard:
            return ClassAttributes(
                icon: "🧙‍♂️",
                color: .blue
            )
        }
    }
}
