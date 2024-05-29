import Foundation
import SwiftUI

final class ListDetailsViewModel: ObservableObject {
    @Published var lists: [ShoppingList] = []
    let repository: PackageRepositoryProtocol
    @Published var list: ShoppingList
    @Published var newProductName = ""
    @Published var newName = ""
    @Published var showRenameSheet = false
    
    init(repository: PackageRepositoryProtocol, list: ShoppingList) {
        self.repository = repository
        self.list = list
    }

    func duplicateList(){
        repository.addList(ShoppingList(name: list.name, products: list.products))
    }
    
    func deleteList(){
        repository.deleteList(list)
    }
    
    func renameList(_ newName: String){
        list.name = newName //todo
    }
    
    func deleteProduct(product: Product) {
        repository.deleteProduct(from: list, productToDelete: product)
        objectWillChange.send()
    }
    
    func addProduct() {
        guard !newProductName.isEmpty else { return }

        let newProduct = Product(name: newProductName)
        repository.addProduct(to: list, newProduct)
        newProductName = ""
    }
    func toggleProduct(product: Product){
        repository.checkProduct(from: list, productToCheck: product)
        objectWillChange.send()
    }

}
