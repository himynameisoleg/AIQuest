import Foundation
import SwiftData

@Model
class Item: Identifiable {
    var id: UUID = UUID()
    var name: String
    var desc: String
    var value: Int
    var experienceRequirement: Int
    
    init(name: String, desc: String, value: Int, experienceRequirement: Int) {
        self.name = name
        self.desc = desc
        self.value = value
        self.experienceRequirement = experienceRequirement
    }
}
