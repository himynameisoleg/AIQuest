//
//  Character.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import Foundation
import SwiftUI

struct Character: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var title: String
    var habit: String
    var className: String
    var backstory: String
    var motivation: String
    var experience: Int
    var gold: Int
    var backpack: [Item]
    var quests: [Quest]
    var image: Image {
        Image(className)
    }
}
