import Foundation

class Package: ObservableObject {
    @Published var lists: [ShoppingList]

    init() {
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

    func addList(_ list: ShoppingList) {
        lists.append(list)
    }

    func deleteList(_ list: ShoppingList) {
        if let index = lists.firstIndex(where: { $0.id == list.id }) {
            lists.remove(at: index)
        }
    }
}

class ShoppingList: Identifiable, ObservableObject {
    var id = UUID()
    @Published var name: String
    @Published var products: [Product]
    //var creationDate: Date

    init(name: String, products: [Product]) {
        self.name = name
        self.products = products
    }

    func deleteProduct(productToDelete: Product) {
        if let index = products.firstIndex(where: { $0 == productToDelete }) {

            products.remove(at: index)
        }
    }

    func addProduct(_ product: Product) {
        products.append(product)
    }

    func checkProduct(productToCheck: Product){
        if let index = products.firstIndex(where: { $0 == productToCheck }) {

            products[index].toggleChecked()
        }
    }

}

class Product: Identifiable, Equatable, Hashable, ObservableObject {
    var id = UUID()
    @Published var name: String
    @Published var isChecked: Bool

    init(name: String, isChecked: Bool = false){
        self.name = name
        self.isChecked = isChecked
    }

    func toggleChecked() {
        isChecked.toggle()
    }

    static func == (lhs: Product, rhs: Product) -> Bool {
        return lhs.name == rhs.name && lhs.isChecked == rhs.isChecked
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(name)
    }

}
