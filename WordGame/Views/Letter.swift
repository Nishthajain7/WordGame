import SwiftUI

struct Letter: View {
    let letter: String
    let isSelected: Bool
    
    var body: some View {
        Text(letter)
            .font(.title)
            .padding()
            .background(Color.blue.opacity(0.2))
            .background(isSelected ? Color.green : Color.blue.opacity(0.7))
            .cornerRadius(8)
    }
}
