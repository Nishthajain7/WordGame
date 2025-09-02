import SwiftUI

struct ActionButtonsView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        HStack(spacing: 16) {
            Button("Backspace") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.backspaceLetter()
                }
            }
            .buttonStyle(SecondaryButtonStyle())
            .disabled(viewModel.currentWord.isEmpty)
            
            Button("Clear") {
                withAnimation(.easeInOut(duration: 0.2)) {
                    viewModel.clearSelection()
                }
            }
            .buttonStyle(SecondaryButtonStyle())
            .disabled(viewModel.currentWord.isEmpty)
            
            Button("Enter") {
                withAnimation(.easeInOut(duration: 0.3)) {
                    viewModel.submitWord()
                }
            }
            .buttonStyle(PrimaryButtonStyle())
            .disabled(viewModel.currentWord.isEmpty)
        }
    }
}
