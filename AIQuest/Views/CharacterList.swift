//
//  CharacterList.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import SwiftUI

struct CharacterList: View {
    var body: some View {
        NavigationSplitView {
            List(characters) { character in

                NavigationLink {
                    CharacterDetail(character: character)
                } label: {
                    CharacterRow(character: character)
                }
            }
            .navigationTitle("Heroes")
            
        } detail: {
            Text("Select your Hero")
        }
    }
}

#Preview {
    CharacterList()
}
