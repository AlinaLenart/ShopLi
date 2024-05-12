import SwiftUI
import Foundation

@main
struct ShopLiApp: App {
    private var package = Package()

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(package: package))
        }
    }
}
