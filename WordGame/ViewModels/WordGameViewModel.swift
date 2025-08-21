import SwiftUI

class WordGameViewModel: ObservableObject {
    @Published private(set) var model: WordGameModel
    @Published var selectedIndices: [Int] = []
    @Published var message: String = ""
    
    init(letters: [String]) {
        self.model = WordGameModel(letters: letters)
    }
    
    var letters: [String] {
        model.letters
    }
    
    var usedWords: [String] {
        model.usedWords
    }
    
    var score: Int {
        model.score
    }
    
    var currentWord: String {
        selectedIndices.map { letters[$0] }.joined()
    }
    
    // MARK: - Game Logic
    
    func toggleSelection(index: Int) {
        if selectedIndices.contains(index) {
            selectedIndices.removeAll { $0 == index }
        } else {
            selectedIndices.append(index)
        }
    }
    
    func submitWord() {
        let word = currentWord
        
        guard !word.isEmpty else { return }
        guard !model.usedWords.contains(word) else {
            message = "Word already used!"
            return
        }
        
        model.usedWords.append(word)
        model.score += word.count
        selectedIndices.removeAll()
        message = "Good word!"
    }
    
    func clearSelection() {
        selectedIndices.removeAll()
        message = ""
    }
}
