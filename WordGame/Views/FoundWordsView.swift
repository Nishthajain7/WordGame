import SwiftUI
import Foundation


struct FoundWordsView: View {
    let words: [String]
    let score: Int
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationView {
            List(words, id: \.self) { word in
                HStack {
                    Text(word)
                        .font(.headline)
                    
                    Spacer()
                    
                    Text("+\(word.count >= 6 ? word.count * 3 : word.count)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .fontWeight(.semibold)
                }
                .padding(.vertical, 4)
            }
        }
    }
}
