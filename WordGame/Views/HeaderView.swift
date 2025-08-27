import SwiftUI

struct HeaderView: View {
    @ObservedObject var viewModel: WordGameViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Word Builder")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.blue, .purple],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("Build words from the letters below")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Button(action: { viewModel.showingWordsList = true }) {
                VStack {
                    Image(systemName: "list.bullet")
                        .font(.title2)
                    Text("\(viewModel.foundWords.count)")
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .foregroundColor(.blue)
                .padding(.horizontal, 12)
                .padding(.vertical, 8)
                .background(Color.blue.opacity(0.1))
                .cornerRadius(12)
            }
        }
    }
}
