import Foundation
import SQLite3

class WordDatabase {
    private var db: OpaquePointer?

    init?(dbPath: String) {
        if sqlite3_open(dbPath, &db) != SQLITE_OK {
            print("Failed to open database")
            return nil
        }
    }

    deinit {
        sqlite3_close(db)
    }

    func isValidWord(_ candidate: String, availableLettersMask: Int) -> Bool {
        let candidateMask = WordDatabase.makeMask(for: candidate)

        guard candidateMask & availableLettersMask == candidateMask else {
            return false
        }

        let query = "SELECT COUNT(*) FROM words WHERE word = ?;"
        var stmt: OpaquePointer?

        if sqlite3_prepare_v2(db, query, -1, &stmt, nil) == SQLITE_OK {
            let upperCaseCandidate = candidate.uppercased()
            let cString = upperCaseCandidate.cString(using: .utf8)!
            sqlite3_bind_text(stmt, 1, cString, Int32(cString.count - 1), nil)

            if sqlite3_step(stmt) == SQLITE_ROW {
                let count = sqlite3_column_int(stmt, 0)
                sqlite3_finalize(stmt)
                return count > 0
            }
        }

        sqlite3_finalize(stmt)
        return false
    }

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
