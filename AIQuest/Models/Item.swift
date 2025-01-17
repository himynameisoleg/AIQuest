//
//  Item.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import Foundation

struct Item: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var value: Int
    var experienceRequirement: Int
}
