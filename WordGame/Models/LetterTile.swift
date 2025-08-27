import SwiftUI

struct LetterTile {
    let letter: String
    let id = UUID()
    var isSelected: Bool = false
    var isUsed: Bool = false
    var selectionOrder: Int = 0
}
