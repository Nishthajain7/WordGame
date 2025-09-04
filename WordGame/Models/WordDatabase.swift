import Foundation
import SQLite

class WordDatabase {
    private let db: Connection
    private let wordsTable = Table("words")
    private let wordColumn = Expression<String>("word")

    init?(dbPath: String) {
        do {
            db = try Connection(dbPath)
        } catch {
            print("Failed to open database: \(error)")
            return nil
        }
    }

    func isValidWord(_ candidate: String, availableLettersMask: Int) -> Bool {
        let candidateMask = WordDatabase.makeMask(for: candidate)
        guard candidateMask & availableLettersMask == candidateMask else {
            return false
        }

        do {
            let query = wordsTable.filter(wordColumn == candidate.uppercased())
            return try db.scalar(query.count) > 0
        } catch {
            print("DB error: \(error)")
            return false
        }
    }

    /// Create a bitmask for letters in the word
    static func makeMask(for word: String) -> Int {
        var mask = 0
        for char in word.uppercased() {
            if let ascii = char.asciiValue {
                let offset = Int(ascii - Character("A").asciiValue!)
                let bitPosition = 25 - offset
                mask |= (1 << bitPosition)
            }
        }
        return mask
    }
}
