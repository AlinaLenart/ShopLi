import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
//                .tabItem {
//                    Label("All Lists", systemImage: "list.dash")
//                }
//            CreateListView(package: package)
//                .tabItem {
//                    Label("Create new", systemImage: "pencil")
//                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
