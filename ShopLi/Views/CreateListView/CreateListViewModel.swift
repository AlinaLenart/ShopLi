import Foundation
import SwiftUI

final class CreateListViewModel: ObservableObject {
    @Published var lists: [ShoppingList] = []
    private let repository: PackageRepositoryProtocol
    @Published var newListName = ""
    @Published var productName = ""
    @Published var productsList: [Product] = []

    init(repository: PackageRepositoryProtocol) {
        self.repository = repository
    }

    func addProduct() {
        guard !productName.isEmpty else { return }
        
        let newProduct = Product(name: productName)
        productsList.append(newProduct)
        productName = ""
    }

    func saveList() {
        let createdList = ShoppingList(name: newListName, products: productsList)
        repository.addList(createdList)
    }
}
