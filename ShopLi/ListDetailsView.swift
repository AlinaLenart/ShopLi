import SwiftUI

final class ListDetailsViewModel: ObservableObject {
    @ObservedObject var list: ShoppingList
    @Published var newProductName = ""
    @Published var isRenameSheetPresented = false
    @Published var newName = ""
    

    init(list: ShoppingList) {
        self.list = list
    }

    func renameList() {
        list.name = newName
    }
    
    func addProduct() {
        guard !newProductName.isEmpty else { return }

        let newProduct = Product(name: newProductName)
        list.addProduct(newProduct)
        newProductName = ""
    }

}

struct ListDetailsView: View {
    @StateObject var viewModel: ListDetailsViewModel

    var body: some View {
        VStack {
            makeList()
            makeAddingNewProduct()

        }
        .navigationBarTitle(viewModel.list.name)
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(trailing: renameButton())
        .sheet(isPresented: $viewModel.isRenameSheetPresented) {renameSheet()}
    }
    
    @ViewBuilder private func renameButton() -> some View {
        Button(action: {
            viewModel.isRenameSheetPresented = true
                }) {
                    Image(systemName: "pencil")
                }
    }
    
    @ViewBuilder private func renameSheet() -> some View {
        NavigationView {
            Form {
                Section(header: Text("Rename List")) {
                    TextField("New Name", text: $viewModel.newName)
                }
                Button("Rename") {
                    viewModel.renameList()
                    viewModel.isRenameSheetPresented = false
                }
            }
            .navigationBarTitle("Rename List", displayMode: .inline)
            .navigationBarItems(leading: Button("Back") {
                viewModel.isRenameSheetPresented = false
            })
            
        }
    }

    
    
    @ViewBuilder private func makeList() -> some View {
        List {
            ForEach(viewModel.list.products) { product in
                ProductRow(viewModel: ProductRowViewModel(product: product,
                                        onTrashTapped: {
                                            viewModel.list.deleteProduct(productToDelete: product)
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

final class ProductRowViewModel: ObservableObject {
    @ObservedObject var product: Product
    var onToggleTapped: () -> Void
    var onTrashTapped: () -> Void


    init(product: Product,  onTrashTapped: @escaping () -> Void) {
        self.product = product
        self.onToggleTapped = {
            product.toggleChecked()
        }
        self.onTrashTapped = onTrashTapped
    }
    

}


struct ProductRow: View {
    @StateObject var viewModel: ProductRowViewModel
    
    var body: some View {
        HStack {
            makeCheckbox()
            Spacer()
            makeTrashDelete()
            
        }
    }
    
    @ViewBuilder private func makeCheckbox() -> some View {
        Button(action: {
            viewModel.onToggleTapped()
        }) {
            Image(systemName: viewModel.product.isChecked ? "checkmark.square.fill" : "square")
        }

        Text(viewModel.product.name)
            .strikethrough(viewModel.product.isChecked)
    }
    @ViewBuilder private func makeTrashDelete() -> some View {
        Button(action: {
            viewModel.onTrashTapped()
        }) {
            Image(systemName: "trash")
        }
        .buttonStyle(BorderlessButtonStyle())
    }
    
}


/*onToggleTapped: {
 product.toggleChecked()
},
onTrashTapped: {
 viewModel.list.deleteProduct(productToDelete: product)
}*/
