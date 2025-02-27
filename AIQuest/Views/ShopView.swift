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
                    // TODO: ItemDetailView + ItemDetailContentView
                    Text("Detail: \(item.desc)")
                }
                .navigationTitle("Market")
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ShopView()
    }
}
