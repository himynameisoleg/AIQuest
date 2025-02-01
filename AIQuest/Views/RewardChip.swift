import SwiftUI

struct RewardChip: View {
    let value: Int
    let label: String
    let color: Color
    
    var body: some View {
        HStack(spacing: 4) {
            Text("\(value)")
                .fontWeight(.bold)
            Text(label)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(color.opacity(0.2))
        .foregroundColor(color)
        .cornerRadius(16)
        .overlay(
            RoundedRectangle(cornerRadius: 16)
                .stroke(color, lineWidth: 1)
        )
    }
}

#Preview {
    RewardChip(value: 12, label: "XP", color: .blue)
}
