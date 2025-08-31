import SwiftUI

struct WordChip: View {
    let word: String
    @State private var isVisible = false
    
    var body: some View {
        HStack(spacing: 4) {
            Text(word)
                .font(.subheadline)
                .fontWeight(.medium)
                .foregroundColor(.green)
            
            
            Text("+\(word.count >= 6 ? word.count * 3 : word.count)")
                .font(.caption2)
                .foregroundColor(.blue)
                .fontWeight(.semibold)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(
            RoundedRectangle(cornerRadius: 8)
                .fill(Color.green.opacity(0.1))
                .overlay(
                    RoundedRectangle(cornerRadius: 8)
                        .stroke(Color.green.opacity(0.3), lineWidth: 1)
                )
        )
        .scaleEffect(isVisible ? 1.0 : 0.8)
        .opacity(isVisible ? 1.0 : 0.0)
        .onAppear {
            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.1)) {
                isVisible = true
            }
        }
    }
}
