import SwiftData
import SwiftUI

struct ItemListView: View {
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \Item.name) private var items: [Item]

    var body: some View {
        ListItems(items: items)
    }
}

private struct ListItems: View {
    var items: [Item]
    @Environment(\.modelContext) private var modelContext
    @State private var isEditorPresented = false
    @State private var confirmationShown = false
    @State private var itemToDelete: Item?

    var body: some View {
        List {
            ForEach(items) { item in
                NavigationLink(value: item) {
                    VStack(alignment: .leading) {
                        Text(item.name)
                            .bold()
                        Text(item.desc)
                    }
                }
            }
        }
        .confirmationDialog(
            "Delete Item?",
            isPresented: $confirmationShown,
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                if let item = itemToDelete {
                    removeItem(item)
                }
            }
            Button("Cancel", role: .cancel) {
                itemToDelete = nil
            }
        }
        .sheet(isPresented: $isEditorPresented) {
            ItemEditor(item: nil)
        }
        .overlay {
            if items.isEmpty {
                ContentUnavailableView {
                    Label(
                        "The markets are empty.",
                        systemImage: "cart.fill"
                    )
                } description: {
                    AddItemButton(isActive: $isEditorPresented)
                }
            }
        }
        .toolbar {
            ToolbarItem(placement: .primaryAction) {
                AddItemButton(isActive: $isEditorPresented)
            }
        }
    }

    private func confirmDeletion(of item: Item) {
        itemToDelete = item
        confirmationShown = true
    }

    private func removeItem(_ item: Item) {
        modelContext.delete(item)
        itemToDelete = nil
    }
}

private struct AddItemButton: View {
    @Binding var isActive: Bool

    var body: some View {
        Button {
            isActive = true
        } label: {
            Label("Add some wares to the shelf", systemImage: "plus")
                .help("Add an Item")
        }
    }
}

#Preview("ItemListView") {
    ModelContainerPreview(ModelContainer.sample) {
        ItemListView()
    }
}

#Preview("Empty ItemListView") {
    NavigationStack {
        ItemListView()
    }
}

#Preview("ListItems") {
    ModelContainerPreview(ModelContainer.sample) {
        ListItems(items: [.bootsOfStriding, .tomeOfArcaneKnowledge])
    }
}
