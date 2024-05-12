import Foundation
import SwiftUI

final class ContentViewModel: ObservableObject {
    @Published var showingCreateListView = false

    let package: Package

    init(package: Package) {
        self.package = package
    }

    func onDelete(indexSet: IndexSet) {
        indexSet.forEach { index in
            package.deleteList(package.getLists()[index])
        }
    }
}

struct ContentView: View {
    @StateObject var viewModel: ContentViewModel

    var body: some View {
        NavigationView {
            VStack {
                makeList()
                Spacer()
                makeCTASection()
            }
            .navigationBarTitle("Your Lists")
            .navigationBarItems(trailing: EditButton())
            .sheet(isPresented: $viewModel.showingCreateListView) {
                CreateListView(viewModel: CreateListViewModel(package: viewModel.package)) //?
            }
        }
    }

    @ViewBuilder private func makeList() -> some View {
        List {
            ForEach(viewModel.package.getLists()) { list in
                NavigationLink(destination: ListView(list: list)) {
                    Text(list.getName())
                }
            }
            .onDelete(perform: viewModel.onDelete)
        }
        .listStyle(.grouped)
    }

    @ViewBuilder private func makeCTASection() -> some View {
        Button(action: {
            viewModel.showingCreateListView = true
        }) {
            Image(systemName: "plus")
                .imageScale(.large)
                .foregroundColor(.accentColor)
                .frame(width: 44, height: 44)
        }
        .padding()
    }
}
