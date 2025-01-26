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
            
            Text("\(CharacterClass(rawValue: character.className)!.attributes.icon)")
            VStack(alignment: .leading) {
                
                
                Text("\(character.name)")
                Text("\(character.habit)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
            Spacer()
            Circle()
                .frame(width: 10, height: 10)
                .foregroundColor(CharacterClass(rawValue: character.className)!.attributes.color)
        }
    }
    
}

#Preview {
    Group {
        CharacterRow(character: characters[0])
        CharacterRow(character: characters[1])
    }
}
