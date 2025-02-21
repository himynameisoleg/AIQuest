import SwiftData
import SwiftUI

struct HandbookView: View {
    @State private var apiKey = ""

    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            Text(Handbook.introduction).padding()
            List(
                Array(Handbook.chapters.enumerated()),
                id: \.element.title
            ) { index, chapter in
                NavigationLink(
                    destination: ChapterDetailView(
                        chapter: chapter, index: index)
                ) {
                    VStack(alignment: .leading) {
                        Text(chapter.title)
                            .bold()
                        Text(chapter.subtitle)
                            .font(.subheadline)
                    }
                }
            }
            .navigationTitle("Handbook")
        }
        //        NavigationStack {
        //            Form {
        //                TextField("API Key", text: $apiKey)
        //            }
        //            .toolbar {
        //                ToolbarItem(placement: .principal) {
        //                    Text("Settings")
        //                }
        //
        //                ToolbarItem(placement: .confirmationAction) {
        //                    Button("Save") {
        //                        withAnimation {
        //                            save()
        //                        }
        //                    }
        //                }
        //            }
        //            .onAppear {
        //            }
        //        }
    }
}

struct ChapterDetailView: View {
    let chapter: Handbook.Chapter
    let index: Int

    var body: some View {
        VStack {
            ScrollView {
                Text(chapter.content)
                    .padding()
                Image("chapter\(index + 1)")
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
            }
        }
        .navigationTitle(chapter.title)
    }
}

#Preview("HandbookView") {
    HandbookView()
}

#Preview("ChapterDetailView") {
    ChapterDetailView(chapter: Handbook.chapters.first!, index: 0)

}
