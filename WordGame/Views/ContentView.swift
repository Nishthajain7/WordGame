import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = WordGameViewModel(
        letters: WordGameViewModel.randomLetters(count: 6),
        dbPath: Bundle.main.path(forResource: "words", ofType: "db") ?? ""
    )
    
    var body: some View {
        NavigationView {
            ZStack {
                // Background gradient
                LinearGradient(
                    colors: [Color.blue.opacity(0.1), Color.purple.opacity(0.1)],
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                ScrollView {
                    VStack(spacing: 20) {
                        // Header
                        HeaderView(viewModel: viewModel)
                        
                        // Letter tiles
                        LetterTilesView(viewModel: viewModel)
                        
                        // Current word display
                        CurrentWordView(viewModel: viewModel)
                        
                        // Action buttons
                        ActionButtonsView(viewModel: viewModel)
                        
                        // Message
                        MessageView(viewModel: viewModel)
                        
                        // Stats
                        StatsView(viewModel: viewModel)
                        
                        if viewModel.foundWords.isEmpty==false {
                            FoundWordsDisplayView(viewModel: viewModel)
                        }
                        
                        Spacer(minLength: 20)
                    }
                    .padding()
                }
            }
        }
        .sheet(isPresented: $viewModel.showingWordsList) {
            FoundWordsView(words: viewModel.foundWords, score: viewModel.score)
        }        }
}
