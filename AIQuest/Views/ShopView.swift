import SwiftUI
import SwiftData

struct ShopView: View {
    let items = ["Apple", "Banana", "Orange", "Pineapple"]

    var body: some View {
        NavigationStack {
        // TODO: ItemListView + ItemRow
            List {
                ForEach(items, id: \.self) { item in
                    NavigationLink(item, value: item)
                }
            }
            .navigationDestination(for: String.self) { textValue in
                // TODO: ItemDetailView + ItemDetailContentView
                Text("Detail: \(textValue)")
            }
            .navigationTitle("Shop")
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ShopView()
        //            .environment(NavigationContext())
    }
}
