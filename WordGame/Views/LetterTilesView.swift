import SwiftUI

struct LetterTilesView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 8), count: 3), spacing: 12) {
            ForEach(Array(viewModel.letterTiles.enumerated()), id: \.element.id) { index, tile in
                LetterTileButton(
                    letter: tile.letter,
                    isSelected: tile.isSelected,
                    isUsed: tile.isUsed
                ) {
                    withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                        viewModel.selectLetter(at: index)
                    }
                }
            }
        }
        .padding(.horizontal)
    }
}
