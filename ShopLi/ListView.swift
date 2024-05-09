import SwiftUI

struct ListView: View {
    @ObservedObject var list: ShoppingList
    @State private var newProductName = ""

    var body: some View {
        VStack {
            List {
                ForEach(list.getProducts()) { product in
                    ProductRow(product: product) {
                        product.toggleChecked()
                    } onThrashTapped: {
                        list.deleteProduct(productToDelete: product)
                    }
//                    ProductRow(product: product, list: list)
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
    let product: Product

    var onToggleTapped: () -> Void
    var onThrashTapped: () -> Void

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
                onThrashTapped()
            }) {
                Image(systemName: "trash")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
