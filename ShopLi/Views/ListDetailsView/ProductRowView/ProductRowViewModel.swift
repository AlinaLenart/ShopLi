import Foundation
import SwiftUI

final class ProductRowViewModel: ObservableObject {
    @Published var product: Product
    @Published var onTrashTapped: () -> Void
    @Published var onToggleTapped: () -> Void

    init(product: Product, onTrashTapped: @escaping () -> Void, onToggleTapped: @escaping () -> Void) {
        self.product = product
        self.onTrashTapped = onTrashTapped
        self.onToggleTapped = onToggleTapped
//        self.onToggleTapped = {
//            product.toggleChecked()
//        }
    }
    
}
