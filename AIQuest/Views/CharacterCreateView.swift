import SwiftUI

struct CharacterCreateView: View {
    @Binding var showCreateView: Bool
    @Environment(\.modelContext) private var modelContext
    @State private var isLoading = false
    @State private var contentVisible = false

    @State private var resultText = ""

    @State private var name = ""
    @State private var title = ""
    @State private var habit = ""
    @State private var selectedClass = "Artificer"
    @State private var backstory = ""
    @State private var motivation = ""
    
    private let availableClasses = [
        "Artificer",
        "Druid",
        "Fighter",
        "Rogue",
        "Wizard"
    ]

    var body: some View {
        Form {
            Section("Select a Class and enter Habit") {
//                Picker("Class", selection: $selectedClass) {
//                    ForEach(CharacterClass.allCases) { category in
//                        Text(category.rawValue).tag(category)
//                    }
//                }
                Picker("Class", selection: $selectedClass) {
                    ForEach(availableClasses, id: \.self) { dndClass in
                        Text(dndClass).tag(dndClass)
                    }
                }
                TextField("Habit", text: $habit)
            }

            if contentVisible {
                Section("Basic Details") {
                    TextField("Name", text: $name)
                    TextField("Title", text: $title)
                }
                Section("Backstory") {
                    TextEditor(text: $backstory)
                        .frame(height: 160)
                }
                Section("Motivation") {
                    TextEditor(text: $motivation)
                        .frame(height: 160)
                }
            }

            Button(action: generateCharacter) {
                if isLoading {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .frame(maxWidth: .infinity)
                } else {
                    Text("AI Generate")
                        .frame(maxWidth: .infinity)
                }
            }
            .padding()
            .disabled(isLoading || habit.isEmpty)
            .background((isLoading || habit.isEmpty) ? Color.green.opacity(0.5) : Color.green)
            .foregroundColor(.white)
            .cornerRadius(10)
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
                        dndClass: selectedClass, backstory: backstory,
                        motivation: motivation)

                    modelContext.insert(newCharacter)

                    showCreateView = false
                }
            }
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

        let requestBody: [String: Any] = [
            "model": OLLAMA_MODEL,
            "prompt": Prompt.createCharacterPrompt(habit: habit).message,
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

                guard
                    let decodedResponse = try? JSONDecoder().decode(
                        OllamaResponse.self, from: data)
                else {
                    resultText = "Error decoding response"
                    return
                }

                guard let jsonData = decodedResponse.response.data(using: .utf8)
                else {
                    resultText = "Error converting string to Data"
                    return
                }

                do {
                    let character = try JSONDecoder().decode(
                        OllamaCharacterCreate.self, from: jsonData)

                    name = character.name
                    title = character.title
                    backstory = character.backstory
                    motivation = character.motivation
                    
                    contentVisible = true
                } catch {
                    resultText =
                        "Error decoding character: \(error.localizedDescription)"
                }

            }
        }.resume()
    }
    
}

#Preview {
    @Previewable @State var visible: Bool = true
    CharacterCreateView(showCreateView: $visible)
}
