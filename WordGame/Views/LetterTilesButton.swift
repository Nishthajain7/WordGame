import SwiftUI

struct LetterTileButton: View {
    let letter: String
    let isSelected: Bool
    let isUsed: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(letter)
                .font(.title)
                .fontWeight(.bold)
                .frame(width: 70, height: 70)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .fill(backgroundColor)
                        .shadow(
                            color: isSelected ? .blue.opacity(0.3) : .black.opacity(0.1),
                            radius: isSelected ? 8 : 4,
                            x: 0,
                            y: isSelected ? 4 : 2
                        )
                )
                .foregroundColor(textColor)
                .scaleEffect(isSelected ? 1.1 : 1.0)
                .animation(.spring(response: 0.3, dampingFraction: 0.7), value: isSelected)
        }
        .disabled(isUsed)
        .buttonStyle(PlainButtonStyle())
    }
    
    private var backgroundColor: Color {
        if isUsed {
            return Color.gray.opacity(0.3)
        } else if isSelected {
            return Color.blue
        } else {
            return Color.white
        }
    }
    
    private var textColor: Color {
        if isUsed {
            return .gray
        } else if isSelected {
            return .white
        } else {
            return .blue
        }
    }
}
