import SwiftUI
import SwiftData

struct ContentView: View {
    @State private var navigationContext = NavigationContext()

    @State private var selection: Tab = .characters
    enum Tab {
        case characters
        case shop
        case settings
    }

    var body: some View {
        TabView(selection: $selection) {
            ThreeColumnContentView()
                .environment(navigationContext)
                .tabItem {
                    Label("Heroes", systemImage: "person.crop.circle").font(.body)
                }
                .tag(Tab.characters)
            ShopView()
                .tabItem {
                    Label("Market", systemImage: "cart")
                }
                .tag(Tab.shop)

            HandbookView()
                .tabItem {
                    Label("Handbook", systemImage: "book")
                }
                .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
