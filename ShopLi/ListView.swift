import SwiftUI

struct ListView: View {
    @ObservedObject var list: ShoppingList

    var body: some View {
        VStack {
            List {
                ForEach(list.getProducts()) { product in
                    ProductRow(product: product, list: list)
                }
            }
            .listStyle(InsetGroupedListStyle())
        }
        .navigationTitle(list.getName())
    }
}

struct ProductRow: View {
    @ObservedObject var product: Product
    var list: ShoppingList

    var body: some View {
        HStack {
            Button(action: {
                product.toggleChecked()
            }) {
                Image(systemName: product.getIsChecked() ? "checkmark.square.fill" : "square")
            }

            Text(product.getName())
                .strikethrough(product.getIsChecked())

            Spacer()

            Button(action: {
                list.deleteProduct(productToDelete: product)
            }) {
                Image(systemName: "trash")
            }
            .buttonStyle(BorderlessButtonStyle())
        }
    }
}
