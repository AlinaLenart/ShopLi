import SwiftUI
import Foundation

@main
struct ShopLiApp: App {
    private var repository = PackageRepository()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(repository: repository))
        }
    }
}


