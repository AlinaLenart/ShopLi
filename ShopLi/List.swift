import Foundation

class Package {
    private var lists: [List]
    init(){
        self.lists = []
    }
}

class List: Identifiable {
    var id = UUID()
    private var name: String
    private var products: [Product]
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
    
    func checkProduct(productToCheck: Product){
        if let index = products.firstIndex(where: { $0 == productToCheck }) {
            
            products[index].toggleChecked()
        }
    }
    
}

class Product: Equatable {
    
    private var name: String
    private var isChecked: Bool
    
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
}
