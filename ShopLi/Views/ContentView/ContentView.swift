import Foundation
import SwiftUI

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
            .sheet(isPresented: $viewModel.showingCreateListView) {
                CreateListView(viewModel: CreateListViewModel(package: viewModel.package))
            }
            
        }
        
    }

    @ViewBuilder private func makeList() -> some View {
        List {
            ForEach(viewModel.package.lists) { list in
                NavigationLink(destination: ListDetailsView(viewModel: ListDetailsViewModel(package: viewModel.package, list: list))) {
                    Text(list.name)
                }
            }
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


