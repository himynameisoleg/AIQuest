//
//  Quest.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import Foundation

struct Quest: Hashable, Codable, Identifiable {
    var id: Int
    var title: String
    var task: String
    var description: String
    var experienceReward: Int
    var goldReward: Int
}
