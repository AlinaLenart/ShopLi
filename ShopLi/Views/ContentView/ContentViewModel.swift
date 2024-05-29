import Foundation

final class ContentViewModel: ObservableObject {
    @Published var showingCreateListView = false
    @Published var package: Package

    init(package: Package) {
        self.package = package
    }


    
}
