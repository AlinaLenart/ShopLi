import Foundation

final class ChooseTemplateViewModel: ObservableObject {
    let package: Package
    @Published var selectedListID: UUID?
    
    init(package: Package) {
        self.package = package
    }
    
    func selectList(_ list: ShoppingList) {
            if selectedListID == list.id {
                selectedListID = nil
            } else {
                selectedListID = list.id
            }
        }

    func duplicateSelectedList(package: Package) {
        guard let selectedListID = selectedListID else { return }
        if let selectedList = package.lists.first(where: { $0.id == selectedListID }) {
            let duplicatedList = ShoppingList(name: selectedList.name, products: selectedList.products)
            package.addList(duplicatedList)
        }
    }
    
}
