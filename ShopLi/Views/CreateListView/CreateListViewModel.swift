import Foundation
import SwiftUI

final class CreateListViewModel: ObservableObject {
    let package: Package
    @Published var newListName = ""
    @Published var productName = ""
    @Published var productsList: [Product] = []

    init(package: Package) {
        self.package = package
    }

    func addProduct() {
        guard !productName.isEmpty else { return }
        
        let newProduct = Product(name: productName)
        productsList.append(newProduct)
        productName = ""
    }

    func saveList() {
        let createdList = ShoppingList(name: newListName, products: productsList)
        package.addList(createdList)
    }
}
