import SwiftUI

struct StatsView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        HStack(spacing: 40) {
            StatItem(title: "Score", value: "\(viewModel.score)", color: .blue)
            StatItem(title: "Words Found", value: "\(viewModel.foundWords.count)", color: .green)
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
    }
}

struct StatItem: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(spacing: 4) {
            Text(value)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundColor(color)
            
            Text(title)
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}
