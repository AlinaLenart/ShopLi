import Foundation

class Package: ObservableObject {
    @Published private var lists: [ShoppingList]

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

    func getLists() -> [ShoppingList] {
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
}

class ShoppingList: Identifiable, ObservableObject {
    var id = UUID()
    @Published private var name: String
    @Published private var products: [Product]
    //var creationDate: Date
    //var isTemplate: Bool

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

    func getName() -> String {
        return name;
    }
    func setName(_ newName: String) -> Void {
        self.name = newName
    }
    func getProducts() -> [Product] {
        return products
    }

}

class Product: Identifiable, Equatable, Hashable, ObservableObject {
    var id = UUID()
    private var name: String
    @Published private var isChecked: Bool

    init(name: String){
        self.name = name
        self.isChecked = false
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

    func getName() -> String {
        return name;
    }

    func getIsChecked() -> Bool {
        return isChecked
    }
}
