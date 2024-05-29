import Foundation
import SwiftUI

struct ProductRow: View {
    var product: Product
    var onTrashTapped: () -> Void
    var onToggleTapped: () -> Void
    
    var body: some View {
        HStack {
            makeCheckbox()
            makeProductName()
            Spacer()
            makeTrashDelete()
        }
    }
    
    @ViewBuilder private func makeCheckbox() -> some View {
        Button(action: {
            onToggleTapped()
        }) {
            Image(systemName: product.isChecked ? "checkmark.square.fill" : "square")
        }
    }

    @ViewBuilder private func makeProductName() -> some View {
        Text(product.name)
            .strikethrough(product.isChecked)
    }
    
    @ViewBuilder private func makeTrashDelete() -> some View {
        Button(action: {
            onTrashTapped()
        }) {
            Image(systemName: "trash")
        }
        .foregroundColor(.red)
        .buttonStyle(BorderlessButtonStyle())
    }
}

