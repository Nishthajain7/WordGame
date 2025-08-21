import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WordGameViewModel(letters: ["C", "A", "T", "R", "E", "P"])
    
    var body: some View {
        VStack {
            Text("Word Builder")
                .font(.largeTitle)
                .padding()
            
            LettersRow(viewModel: viewModel)
            
            Text("Current Word: \(viewModel.currentWord)")
                .font(.title3)
                .padding()
            
            ActionButtons(viewModel: viewModel)
            
            Text(viewModel.message)
                .foregroundColor(.red)
                .padding()
            
            Text("Score: \(viewModel.score)")
                .font(.title2)
                .bold()
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
    }
}
