import SwiftData
import SwiftUI

struct ShopView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        NavigationStack {
            ItemListView()
                .navigationDestination(for: Item.self) { item in
                    // TODO: ItemDetailView + ItemDetailContentView
                    Text("Detail: \(item.desc)")
                }
                .navigationTitle("Shop")
        }
    }
}

#Preview {
    ModelContainerPreview(ModelContainer.sample) {
        ShopView()
    }
}
