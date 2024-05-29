import SwiftUI

struct ListDetailsView: View {
    @ObservedObject var viewModel: ListDetailsViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            makeList()
            makeAddingNewProduct()

        }
        .navigationBarTitle(viewModel.list.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: optionsMenu())
        .sheet(isPresented: $viewModel.showRenameSheet) {
            RenameListView(viewModel: viewModel)
        }
        
    }
    
    @ViewBuilder private func optionsMenu() -> some View {
        Menu {
            Button(action: {
                viewModel.showRenameSheet = true
            }) {
                Label("Rename List", systemImage: "pencil")
            }
            Button(action: {
                viewModel.duplicateList()
            }) {
                Label("Duplicate List", systemImage: "doc.on.doc")
            }
            Button(action: {
                viewModel.deleteList()
                presentationMode.wrappedValue.dismiss()
            })
            {
                Label("Delete List", systemImage: "trash")
            }
            
        } label: {
            Image(systemName: "ellipsis.circle")
        }
        
    }
    
    
    @ViewBuilder private func makeList() -> some View {
        List {
            ForEach(viewModel.list.products) { product in
                ProductRow(viewModel: ProductRowViewModel(product: product,
                      onTrashTapped: {
                            viewModel.list.deleteProduct(productToDelete: product)
                      },
                      onToggleTapped: {
                            product.toggleChecked()
                      }))
            }

        }
        .padding()
        .listStyle(.insetGrouped)
    }
    
    @ViewBuilder private func makeAddingNewProduct() -> some View {
        VStack {
            TextField("Add new product", text: $viewModel.newProductName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(15)
                .fixedSize()
                .disableAutocorrection(true)
        
            Button(action: {
                viewModel.addProduct()
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Product")
                }
            }
            .buttonStyle(BorderedButtonStyle())
            .clipShape(Capsule())
            .padding()
        }
    }
    
}




/*onToggleTapped: {
 product.toggleChecked()
},
onTrashTapped: {
 viewModel.list.deleteProduct(productToDelete: product)
}*/

