import SwiftData
import SwiftUI

struct QuestCompletionView: View {
    let quest: Quest

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Congratulations, Hero!")
                        .font(.title)
                        .bold()
                        .padding(.bottom)
                }
                Image("quest-complete")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: 200)
                    .cornerRadius(50)
                    .padding(.bottom)

                Divider()
                    .padding(.vertical)

                VStack(alignment: .leading) {
                    if quest.progressionStage == 6 {
                        Text("The journey draws to a close:")
                            .font(.headline)
                    } else {
                        Text("The journey continues:")
                            .font(.headline)
                    }

                    Text(quest.narrative[quest.progressionStage])
                        .padding(.bottom)

                    Text("**Task:** \(quest.task)")
                }

            }
            .padding()
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Dismiss", role: .cancel) {
                        dismiss()
                    }
                }
            }
            Spacer()
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        QuestCompletionView(quest: Quest.daily)
            .environment(NavigationContext())
    }
}
