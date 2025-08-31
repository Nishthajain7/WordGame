import SwiftUI

struct LetterTilesView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        LazyVGrid(
            columns: Array(repeating: GridItem(.fixed(80), spacing: 12), count: 3),
            spacing: 12
        ) {
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
        .frame(maxWidth: 300) // Limit the total width
        .padding(.horizontal)
    }
}
