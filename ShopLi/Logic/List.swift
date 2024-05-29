import Foundation

protocol PackageRepositoryProtocol {
    func getShoppingLists() -> [ShoppingList]
    func addList(_ list: ShoppingList)
    func deleteList(_ list: ShoppingList)
    func deleteProduct(from list: ShoppingList, productToDelete: Product)
    func addProduct(to list: ShoppingList, _ product: Product)
    func checkProduct(from list: ShoppingList, productToCheck: Product)
    
}

class PackageRepository: PackageRepositoryProtocol {
    private var lists: [ShoppingList]
    
    init(){
        self.lists = []
        let product1 = Product(name: "Apples")
        let product2 = Product(name: "Bananas")
        let product3 = Product(name: "Vitamin D")
        let product4 = Product(name: "Magnesium")

        let list1 = ShoppingList(name: "Grocery", products: [product1, product2])
        let list2 = ShoppingList(name: "Suplements", products: [product3, product4])

        addList(list1)
        addList(list2)
    }
    
    func getShoppingLists() -> [ShoppingList] {
        return lists
    }
    
    func addList(_ list: ShoppingList) {
        lists.append(list)
    }
    
    func deleteList(_ list: ShoppingList) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists.remove(at: index)
        }
    }
    
    func deleteProduct(from list: ShoppingList, productToDelete: Product) { //przekaz list.id
        guard let searchedList = lists.first(where: { $0.id == list.id }) else {
            return
        }
        if let index = searchedList.products.firstIndex(where: { $0 == productToDelete }) {
            searchedList.products.remove(at: index)
        }
    }
    
    func addProduct(to list: ShoppingList, _ product: Product) {
        guard let searchedList = lists.first(where: { $0.id == list.id }) else {
            return
        }
        searchedList.products.append(product)
        
    }
    
    func checkProduct(from list: ShoppingList, productToCheck: Product) {
        guard let searchedList = lists.first(where: { $0.id == list.id }),
              let searchedProduct = searchedList.products.first(where: { $0.id == productToCheck.id}) else {
            return
        }
        searchedProduct.isChecked.toggle()
        
    }
    
}


class ShoppingList: Identifiable {
    var id = UUID()
    var name: String
    var products: [Product]
    //var creationDate: Date

    init(name: String, products: [Product]) {
        self.name = name
        self.products = products
    }

}

class Product: Identifiable {
    var id = UUID()
    var name: String
    var isChecked: Bool

    init(name: String, isChecked: Bool = false){
        self.name = name
        self.isChecked = isChecked
    }

    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.isChecked == rhs.isChecked
    }


}
