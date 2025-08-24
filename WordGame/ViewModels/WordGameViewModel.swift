import SwiftUI

class WordGameViewModel: ObservableObject {
    @Published private(set) var model: WordGameModel
    @Published var selectedIndices: [Int] = []
    @Published var message: String = ""
    @Published var messageColor: Color = .red
    
    private var db: WordDatabase
    
    init(letters: [String], dbPath: String) {
        if let database = WordDatabase(dbPath: dbPath) {
            self.db = database
        } else {
            fatalError("Could not load words.db")
        }
        self.model = WordGameModel(letters: letters)
    }
    
    
    var letters: [String] { model.letters }
    var usedWords: [String] { model.usedWords }
    var score: Int { model.score }
    
    var currentWord: String {
        selectedIndices.map { letters[$0] }.joined()
    }
    
    private var availableLettersMask: Int {
        WordDatabase.makeMask(for: model.letters.joined())
    }
    
    func toggleSelection(index: Int) {
        if selectedIndices.contains(index) {
            selectedIndices.removeAll { $0 == index }
        } else {
            selectedIndices.append(index)
        }
    }
    
    func submitWord() {
        let word = currentWord.uppercased()
        guard !word.isEmpty else { return }
        
        guard !model.usedWords.contains(word) else {
            message = "Word already used!"
            messageColor = .red
            return
        }
        
        if db.isValidWord(word, availableLettersMask: availableLettersMask) {
            model.usedWords.append(word)
            model.score += word.count
            selectedIndices.removeAll()
            message = "Valid word!"
            messageColor = .green   // <-- success
        } else {
            message = "Not a valid word!"
            messageColor = .red     // <-- failure
            selectedIndices.removeAll()
        }
    }
    
    func clearSelection() {
        selectedIndices.removeAll()
        message = ""
    }
}
