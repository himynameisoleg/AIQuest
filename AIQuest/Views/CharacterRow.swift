//
//  CharacterRow.swift
//  AIQuest
//
//  Created by op on 1/16/25.
//

import SwiftUI

struct CharacterRow: View {
    var character: Character

    var body: some View {
        HStack {
//            character.image
//                .resizable()
//                .frame(width: 50, height: 50)
            Text(character.name)
            Spacer()
        }
    }
}

#Preview {
    Group {
        CharacterRow(character: characters[0])
        CharacterRow(character: characters[1])
    }
}
