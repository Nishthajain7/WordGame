import SwiftUI
import Foundation

struct FoundWordsDisplayView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Words Found")
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundColor(.blue)
                
                Spacer()
                
                if !viewModel.foundWords.isEmpty {
                    Button("View All") {
                        viewModel.showingWordsList = true
                    }
                    .font(.caption)
                    .foregroundColor(.blue)
                }
            }
            
            LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 8) {
                ForEach(viewModel.foundWords, id: \.self) { word in
                    WordChip(word: word)
                }
            }
            
        }
        .frame(maxWidth: 300) // Match the letter tiles width
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color.white)
                .shadow(color: .black.opacity(0.1), radius: 8, x: 0, y: 4)
        )
        .animation(.easeInOut(duration: 0.3), value: viewModel.foundWords.count)
    }
}

struct FoundWordsView: View {
    let words: [String]
    let score: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(words, id: \.self) { word in
                HStack {
                    Text(word)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("+\(word.count >= 6 ? word.count * 3 : word.count)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 4)
            }
            .navigationTitle("Found Words")
        }
    }
}
