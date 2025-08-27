import SwiftUI	

class WordGameViewModel: ObservableObject {
    @Published var model: WordGameModel
    @Published var letterTiles: [LetterTile]
    @Published var message: String = "Start building words!"
    @Published var messageColor: Color = .primary
    @Published var foundWords: [String] = []
    @Published var showingWordsList = false
    
    private let database: WordDatabase?
    private let availableLettersMask: Int
    private var selectionCounter = 0
    
    init(letters: [String], dbPath: String) {
        self.model = WordGameModel(letters: letters)
        self.letterTiles = letters.map { LetterTile(letter: $0) }
        self.database = WordDatabase(dbPath: dbPath)
        self.availableLettersMask = WordDatabase.makeMask(for: letters.joined())
    }
    
    var currentWord: String {
        letterTiles
            .filter { $0.isSelected }
            .sorted { $0.selectionOrder < $1.selectionOrder }
            .map { $0.letter }
            .joined()
    }
    
    var score: Int {
        model.score
    }
    
    func selectLetter(at index: Int) {
        guard !letterTiles[index].isUsed else { return }
        
        if letterTiles[index].isSelected {
            let deselectedOrder = letterTiles[index].selectionOrder
            letterTiles[index].isSelected = false
            letterTiles[index].selectionOrder = 0
            
            for i in letterTiles.indices {
                if letterTiles[i].isSelected && letterTiles[i].selectionOrder > deselectedOrder {
                    letterTiles[i].selectionOrder -= 1
                }
            }
            
            selectionCounter = letterTiles.filter { $0.isSelected }.count
            
        } else {
            selectionCounter += 1
            letterTiles[index].isSelected = true
            letterTiles[index].selectionOrder = selectionCounter
        }
        
        updateMessage()
    }
    func submitWord() {
        let word = currentWord.uppercased()
        
        guard !word.isEmpty else {
            showMessage("Select some letters first!", color: .orange)
            return
        }
        
        guard word.count >= 3 else {
            showMessage("Words must be at least 3 letters long!", color: .orange)
            return
        }
        
        guard !model.usedWords.contains(word) else {
            showMessage("You've already found '\(word)'!", color: .orange)
            return
        }
        
        guard let database = database else {
            showMessage("Database not available!", color: .red)
            return
        }
        
        if database.isValidWord(word, availableLettersMask: availableLettersMask) {
            // Valid word found!
            let points = calculatePoints(for: word)
            model.score += points
            model.usedWords.append(word)
            foundWords.append(word)
            
            showMessage("'\(word)' found! +\(points) points", color: .green)
            clearSelection()
        } else {
            showMessage("'\(word)' is not a valid word", color: .red)
        }
    }
    
    func clearSelection() {
        for i in letterTiles.indices {
            letterTiles[i].isSelected = false
            letterTiles[i].selectionOrder = 0
        }
        selectionCounter = 0
        updateMessage()
    }
    
    func resetGame() {
        model.score = 0
        model.usedWords.removeAll()
        foundWords.removeAll()
        
        for i in letterTiles.indices {
            letterTiles[i].isSelected = false
            letterTiles[i].isUsed = false
            letterTiles[i].selectionOrder = 0
        }
        
        showMessage("Game reset! Start building words!", color: .blue)
    }
    
    private func calculatePoints(for word: String) -> Int {
        let basePoints = word.count
        let bonusPoints = word.count >= 6 ? word.count * 2 : 0
        return basePoints + bonusPoints
    }
    
    private func showMessage(_ text: String, color: Color) {
        message = text
        messageColor = color
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            if self.message == text {
                self.updateMessage()
            }
        }
    }
    
    private func updateMessage() {
        if currentWord.isEmpty {
            message = foundWords.isEmpty ? "Start building words!" : "Build another word!"
            messageColor = .secondary
        } else {
            message = "Tap Submit to check '\(currentWord)'"
            messageColor = .primary
        }
    }
}
