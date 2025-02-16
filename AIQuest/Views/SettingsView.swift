import SwiftData
import SwiftUI

struct SettingsView: View {
    @State private var apiKey = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Form {
                TextField("API Key", text: $apiKey)
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Text("Settings")
                }

                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        withAnimation {
//                            save()
                        }
                    }
                }
            }
            .onAppear {
//                if let quest {
//                    // Edit the incoming quest.
//
//                }
            }
        }
    }
}

#Preview {
    SettingsView()
}
