import Foundation
import SwiftUI

struct ProductRow: View {
    @ObservedObject var viewModel: ProductRowViewModel
    
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
            viewModel.onToggleTapped()
        }) {
            Image(systemName: viewModel.product.isChecked ? "checkmark.square.fill" : "square")
        }
    }

    @ViewBuilder private func makeProductName() -> some View {
        Text(viewModel.product.name)
            .strikethrough(viewModel.product.isChecked)
    }
    
    @ViewBuilder private func makeTrashDelete() -> some View {
        Button(action: {
            viewModel.onTrashTapped()
        }) {
            Image(systemName: "trash")
        }
        .buttonStyle(BorderlessButtonStyle())
    }
}

