import Foundation

final class ContentViewModel: ObservableObject {
    @Published var showingCreateListView = false
    @Published var lists: [ShoppingList] = []
    let repository: PackageRepositoryProtocol

    init(repository: PackageRepositoryProtocol) {
        self.repository = repository
    }
    
    func getLists(){
        lists = repository.getShoppingLists()
    }
    
}
