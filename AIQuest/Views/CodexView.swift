import SwiftUI

struct CodexView: View {
    @State private var apiKey: String = ""
    
    var body: some View {
        ZStack {
            Color.black
                .ignoresSafeArea(.all)
            VStack {
                Text("\"Present the Codex\"")
                    .foregroundStyle(.white)
                    .padding()
                TextField("Enter Code", text: $apiKey)
                    .autocorrectionDisabled()
                    .padding(.horizontal)
            }
            .textFieldStyle(.roundedBorder)
        }
    }
}

#Preview {
    CodexView()
}
