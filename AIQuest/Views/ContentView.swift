//
//  ContentView.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import SwiftUI

struct ContentView: View {
    @State private var selection: Tab = .characters
    
    enum Tab {
        case characters
        case store
        case settings
    }
    
    var body: some View {
        TabView(selection: $selection) {
            CharacterList()
                .tabItem {
                    Label("Heroes", systemImage: "person.crop.circle")
                }
                .tag(Tab.characters)
            
            StoreView()
                .tabItem {
                    Label("Store", systemImage: "cart")
                }
                .tag(Tab.store)

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
}
