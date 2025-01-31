import SwiftUI

struct CharacterCreateView: View {
    @Binding var showCreateView: Bool
    @Environment(\.modelContext) private var modelContext
    @State var isLoading = false
    @State var resultText = ""

    @State private var name = ""
    @State private var title = ""
    @State private var habit = ""
    @State private var selectedClass: CharacterClass = .Artificer
    @State private var backstory = ""
    @State private var motivation = ""

    var prompt = Prompt.sampleCharacterCreatePrompt.message

    var body: some View {
        Form {
            Section("Basic Details") {
                TextField("Name", text: $name)
                TextField("Title", text: $title)
                Picker("Class", selection: $selectedClass) {
                    ForEach(CharacterClass.allCases) { category in
                        Text(category.rawValue).tag(category)
                    }
                }
                TextField("Habit", text: $habit)
            }
            Section("Backstory") {
                TextEditor(text: $backstory)
            }
            Section("Motivation") {
                TextEditor(text: $motivation)
            }
            #if DEBUG
            Section("debug") {
                TextEditor(text: $resultText)
            }
            #endif

        }
        .toolbar {
            ToolbarItem(placement: .cancellationAction) {
                Button("Cancel") {
                    showCreateView = false
                }
            }
            ToolbarItem(placement: .confirmationAction) {

                Button("Create") {
                    let newCharacter = Character.init(
                        name: name, title: title, habit: habit,
                        className: selectedClass.rawValue, backstory: backstory,
                        motivation: motivation)

                    modelContext.insert(newCharacter)
                    // TODO: generate the QUESTS!

                    showCreateView = false
                }
            }
        }
        VStack {

            Button(action: generateCharacter) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                    Text("Thinking...")
                } else {
                    Text("AI Generate")
                }
            }
            .padding()
            .disabled(isLoading)
            .background(isLoading ? Color.green.opacity(0.5) : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
        }
    }

    func generateCharacter() {
        isLoading = true
        guard let url = URL(string: "http://localhost:11434/api/generate")
        else {
            resultText = "Invalid URL"
            isLoading = false
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Match the curl request format exactly
        let requestBody: [String: Any] = [
            "model": "mistral",
            "prompt": prompt,
            "stream": false,
        ]

        request.httpBody = try? JSONSerialization.data(
            withJSONObject: requestBody)

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                isLoading = false

                if let error = error {
                    resultText = "Error: \(error.localizedDescription)"
                    return
                }

                guard let data = data else {
                    resultText = "No data received"
                    return
                }
                
                guard let decodedResponse = try? JSONDecoder().decode(OllamaResponse.self, from: data) else {
                    resultText = "Error decoding response"
                    return
                }

                guard let jsonData = decodedResponse.response.data(using: .utf8) else {
                    resultText = "Error converting string to Data"
                    return
                }

                do {
                    let character = try JSONDecoder().decode(OllamaCharacterCreate.self, from: jsonData)
                    
                    name = character.name
                    title = character.title
                    backstory = character.backstory
                    motivation = character.motivation
                } catch {
                    resultText = "Error decoding character: \(error.localizedDescription)"
                }
            }
        }.resume()
    }
}

#Preview {
    @Previewable @State var visible: Bool = true
    CharacterCreateView(
        showCreateView: $visible,
        prompt: Prompt.sampleCharacterCreatePrompt.message)
}
