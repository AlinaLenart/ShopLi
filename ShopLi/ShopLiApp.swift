import SwiftUI
import Foundation

@main
struct ShopLiApp: App {
    private var package = Package()
    private var templates: [ShoppingList] = []

    var body: some Scene {
        WindowGroup {
            ContentView(viewModel: ContentViewModel(package: package, templates: templates))
        }
    }
}

struct ContentView_Preview: PreviewProvider {
    static var previews: some View {
        let package = Package()
        let templates: [ShoppingList] = []
        ContentView(viewModel: ContentViewModel(package: package, templates: templates))
    }
}
