import SwiftUI

struct CurrentWordView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        VStack(spacing: 8) {
            Text("Current Word")
                .font(.headline)
                .foregroundColor(.secondary)
            
            Text(viewModel.currentWord.isEmpty ? "—" : viewModel.currentWord)
                .font(.title)
                .fontWeight(.semibold)
                .padding(.horizontal, 20)
                .padding(.vertical, 12)
                .background(
                    RoundedRectangle(cornerRadius: 12)
                        .fill(Color.gray.opacity(0.1))
                        .overlay(
                            RoundedRectangle(cornerRadius: 12)
                                .stroke(viewModel.currentWord.isEmpty ? Color.clear : Color.blue, lineWidth: 2)
                        )
                )
                .animation(.easeInOut(duration: 0.2), value: viewModel.currentWord)
        }
    }
}
