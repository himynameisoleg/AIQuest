struct Item: Hashable, Codable, Identifiable {
    var id: Int
    var name: String
    var description: String
    var value: Int
    var experienceRequirement: Int
}
