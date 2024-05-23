import Foundation
import SwiftUI

struct CreateListView: View {

    @ObservedObject var viewModel: CreateListViewModel //ObservedObject or StateObject
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
                .disableAutocorrection(true)
                
        }
    }
    
    @ViewBuilder private func makeAddedProductsList() -> some View {
        
        Section(header: Text("Added Products")) {
            
            if viewModel.productsList.isEmpty {
                Text("List is empty")
                    .opacity(0.2)
                
            }
            
            ForEach(viewModel.productsList, id: \.self) { product in
                HStack {
                    Image(systemName: "square")
                    Text(product.name)
                }
            }
        }
    }
    
    @ViewBuilder private func makeAddProduct() -> some View {
        HStack {
            TextField("Enter product name", text: $viewModel.productName)
                .imageScale(.medium)
                .disableAutocorrection(true)
            
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
                viewModel.saveList()
                presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save List")
            }
        }
    }

    
}
