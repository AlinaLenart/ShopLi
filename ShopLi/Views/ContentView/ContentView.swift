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
                CreateListView(viewModel: CreateListViewModel(repository: viewModel.repository))
            }
            .onAppear(perform: {
                viewModel.getLists()
            })
            
        }
        
    }

    @ViewBuilder private func makeList() -> some View {
        List {
            ForEach(viewModel.lists) { list in
                NavigationLink(destination: ListDetailsView(viewModel: ListDetailsViewModel(repository: viewModel.repository, list: list))) {
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


