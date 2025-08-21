import SwiftUI

struct ActionButtons: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        HStack {
            Button("Submit") {
                viewModel.submitWord()
            }
            .buttonStyle(.borderedProminent)
            
            Button("Clear") {
                viewModel.clearSelection()
            }
            .buttonStyle(.bordered)
        }
        .padding()
    }
}
