import Foundation
import SwiftData

@Model
class ToDo: Identifiable {

    var id: UUID = UUID()
    var name: String
    var note: String

    init( name: String, note: String) {
        self.name = name
        self.note = note
    }
}
