import Foundation
import SwiftUI

final class ListDetailsViewModel: ObservableObject {
    let package: Package
    @Published var list: ShoppingList
    @Published var newProductName = ""
    @Published var newName = ""
    @Published var showRenameSheet = false
    
    init(package: Package, list: ShoppingList) {
        self.package = package
        self.list = list
    }

    func duplicateList(){
        package.addList(ShoppingList(name: list.name, products: list.products))
    }
    
    func deleteList(){
        package.deleteList(list)
    }
    
    func renameList(_ newName: String){
        list.name = newName
    }
    
    func addProduct() {
        guard !newProductName.isEmpty else { return }

        let newProduct = Product(name: newProductName)
        list.addProduct(newProduct)
        newProductName = ""
    }

}
