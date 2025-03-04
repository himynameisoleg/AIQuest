import SwiftData
import SwiftUI

struct ShopView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            Image("market")
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)

            ItemListView()
                .navigationDestination(for: Item.self) { item in
                    ItemDetailView(item: item)
                }
                .navigationTitle("Market")
        }
    }
}

#Preview("ShopView") {
    ModelContainerPreview(ModelContainer.sample) {
        ShopView()
    }
}
