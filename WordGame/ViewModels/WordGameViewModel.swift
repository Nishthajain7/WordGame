import SwiftUI	

class WordGameViewModel: ObservableObject {
    @Published var model: WordGameModel
    @Published var letterTiles: [LetterTile]
    @Published var message: String = "Start building words!"
    @Published var messageColor: Color = .primary
    @Published var foundWords: [String] = []
    @Published var showingWordsList = false
    @Published var selectedLetters: [String] = []
    
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
        selectedLetters.joined()
    }
    
    var score: Int {
        model.score
    }
    
    static func randomLetters(count: Int) -> [String] {
        let alphabet = (UnicodeScalar("A").value...UnicodeScalar("Z").value).compactMap {UnicodeScalar($0)}.map {String($0)}
        let letters = Array(alphabet.shuffled().prefix(count))
        
        return letters
    }

    
    func selectLetter(at index: Int) {
        guard !letterTiles[index].isUsed else { return }
        
        let letter = letterTiles[index].letter
        
        let currentCount = selectedLetters.filter { $0 == letter }.count
        
        let availableCount = letterTiles.filter { $0.letter == letter }.count
        
        if currentCount < availableCount {
            selectedLetters.append(letter)
            
            updateTileStates()
        }
        
        updateMessage()
    }
    
    private func updateTileStates() {

        for i in letterTiles.indices {
            letterTiles[i].isSelected = false
        }
        
        var letterCounts: [String: Int] = [:]
        for letter in selectedLetters {
            letterCounts[letter, default: 0] += 1
        }
        
        for (letter, count) in letterCounts {
            let tilesForLetter = letterTiles.enumerated().filter { $0.element.letter == letter }
            
            for (index, tileIndex) in tilesForLetter.enumerated() {
                if index < count {
                    letterTiles[tileIndex.offset].isSelected = true
                }
            }
        }
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
        selectedLetters.removeAll()
        updateTileStates()
        updateMessage()
    }
    
    func backspaceLetter() {
        guard !selectedLetters.isEmpty else { return }
        selectedLetters.removeLast()
        updateTileStates()
        updateMessage()
    }
    
    func resetGame() {
        model.score = 0
        model.usedWords.removeAll()
        foundWords.removeAll()
        selectedLetters.removeAll()
        selectionCounter = 0
        
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
