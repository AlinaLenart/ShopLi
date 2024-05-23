import Foundation

final class ContentViewModel: ObservableObject {
    @Published var showingCreateListView = false
    @Published var package: Package

    init(package: Package) {
        self.package = package
    }

    func onDelete(indexSet: IndexSet) {
        indexSet.forEach { index in
            package.deleteList(package.lists[index])
        }
    }
}
