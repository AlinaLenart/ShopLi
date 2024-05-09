import SwiftUI

@main
struct ShopLiApp: App {
    private var package = Package()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(package: Package()))
        }
    }
}
