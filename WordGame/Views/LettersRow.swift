import SwiftUI

struct LettersRow: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        HStack() {
            ForEach(viewModel.letters.indices, id: \.self) { index in
                Button {
                    viewModel.toggleSelection(index: index)
                } label: {
                    Letter(
                        letter: viewModel.letters[index],
                        isSelected: viewModel.selectedIndices.contains(index)
                    )
                }
                .buttonStyle(.plain)
            }
        }
    }
}
