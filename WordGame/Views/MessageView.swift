import SwiftUI

struct MessageView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        Text(viewModel.message)
            .font(.body)
            .foregroundColor(viewModel.messageColor)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
            .padding(.vertical, 12)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(viewModel.messageColor.opacity(0.1))
            )
            .animation(.easeInOut(duration: 0.3), value: viewModel.message)
    }
}
