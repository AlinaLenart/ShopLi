import Foundation
import SwiftUI

struct ContentView: View {
    @State private var newListName = ""
    @StateObject private var package = Package()
    @State private var showingCreateListView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(package.getLists()) { list in
                        NavigationLink(destination: ListView(list: list)) {
                            Text(list.getName())
                        }
                    }
                }
                .navigationTitle("Lists")
                .listStyle(.grouped)
            }
            .navigationBarItems(trailing:
                Button(action: {
                showingCreateListView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingCreateListView) {
            
                CreateListView(package: package)
                
            }
        }
        
    }
}
