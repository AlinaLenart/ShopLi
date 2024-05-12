import Foundation
import SwiftUI

final class CreateListViewModel: ObservableObject {
    @Published var newListName = ""
    @Published var productName = ""
    @Published var productsList: [Product] = []

    let package: Package

    init(package: Package) {
        self.package = package
    }

    func addProduct() {
        guard !productName.isEmpty else { return }
        
        let newProduct = Product(name: productName)
        productsList.append(newProduct)
        productName = ""
    }

    func saveList(presentationMode: Binding<PresentationMode>) {
        let createdList = ShoppingList(name: newListName, products: productsList)
        package.addList(createdList)
        presentationMode.wrappedValue.dismiss()
    }
}


struct CreateListView: View {

    @StateObject var viewModel: CreateListViewModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            makeTitleSection()
            makeAddProduct()
            makeAddedProductsList()
            makeSaveList()
               
        }
        .navigationBarTitle("Create List")
    }
    
    @ViewBuilder private func makeTitleSection() -> some View {
        
        Section(header: Text("List Details")) {
            TextField("Enter list name", text: $viewModel.newListName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize()
                .font(.title)

                
        }
    }
    
    @ViewBuilder private func makeAddedProductsList() -> some View {
        
        Section(header: Text("Added Products")) {
            ForEach(viewModel.productsList, id: \.self) { product in
                HStack {
                    Image(systemName: "square")
                    Text(product.getName())
                }
            }
        }
    }
    
    @ViewBuilder private func makeAddProduct() -> some View {
        HStack {
            TextField("Enter product name", text: $viewModel.productName)
                .imageScale(.medium)
            
            Button(action: {
                viewModel.addProduct()
            }) {
                Label("Add Product", systemImage: "plus")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }

    
    @ViewBuilder private func makeSaveList() -> some View {
        Section {
            Button(action: {
                viewModel.saveList(presentationMode: presentationMode)
            }) {
                Text("Save List")
            }
        }
    }

    
}
