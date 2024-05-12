import SwiftUI

final class ListDetailsViewModel: ObservableObject {
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

struct ListDetailsView: View {
    @ObservedObject var list: ShoppingList
    @State private var newProductName = ""

    var body: some View {
        VStack {
            List {
                ForEach(list.getProducts()) { product in
                    ProductRow(product: product,
                        onToggleTapped: {
                            product.toggleChecked()
                        },
                        onTrashTapped: {
                            list.deleteProduct(productToDelete: product)
                        })
                }

            }
            .padding()
            .listStyle(.insetGrouped)

            VStack {
                TextField("Add new product", text: $newProductName)
                    .padding(EdgeInsets(top: 8, leading: 12, bottom: 8, trailing: 4))
                    .background(Color.secondary.opacity(0.1))
                    .cornerRadius(8)
                    .fixedSize()

                Button(action: {
                    guard !newProductName.isEmpty else { return }

                    let newProduct = Product(name: newProductName)
                    list.addProduct(newProduct)
                    newProductName = ""
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
        .navigationBarTitle(list.getName())
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ProductRow: View {
    @ObservedObject var product: Product
    var onToggleTapped: () -> Void
    var onTrashTapped: () -> Void

    var body: some View {
        HStack {
            Button(action: {
                onToggleTapped()
            }) {
                Image(systemName: product.getIsChecked() ? "checkmark.square.fill" : "square")
            }

            Text(product.getName())
                .strikethrough(product.getIsChecked())

            Spacer()

            Button(action: {
                onTrashTapped()
            }) {
                Image(systemName: "trash")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
