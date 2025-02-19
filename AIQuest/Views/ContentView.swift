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
                    Label("Heroes", systemImage: "person.crop.circle")
                }
                .tag(Tab.characters)
            ShopView()
                .tabItem {
                    Label("Shop", systemImage: "cart")
                }
                .tag(Tab.shop)

            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
                .tag(Tab.settings)
        }
    }
}

#Preview {
    ContentView()
        .modelContainer(try! ModelContainer.sample())
}
