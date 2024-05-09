import Foundation
import SwiftUI

struct ContentView: View {
    @State private var newListName = ""
    @StateObject private var package = Package()
    @State private var showingCreateListView = false
    @State private var isEditMode = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(package.getLists()) { list in
                        NavigationLink(destination: ListView(list: list)) {
                            Text(list.getName())
                        }
                    }
                    .onDelete { indexSet in
                        indexSet.forEach { index in
                            package.deleteList(package.getLists()[index])
                        }
                    }
                }
                .listStyle(.grouped)
                

                Spacer()

                Button(action: {
                    showingCreateListView = true
                }) {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .foregroundColor(.accentColor)
                        .frame(width: 44, height: 44)
                }
                .padding()
            }
            .navigationBarTitle("Your Lists")
            .navigationBarItems(trailing: EditButton())
            .sheet(isPresented: $showingCreateListView) {
                CreateListView(package: package)
            }
        }
    }
}
