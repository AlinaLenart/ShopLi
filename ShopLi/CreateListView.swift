//
//  AddView.swift
//  ShopLi
//
//  Created by Alina Lenart on 30/04/2024.
//

import Foundation
import SwiftUI

struct CreateListView: View {
    @State private var newListName = ""
    @State private var productName = ""
    @State private var productsList: [Product] = []
    @Environment(\.presentationMode) var presentationMode
    //@State private var closeAddingView = false
    var package: Package
    
    var body: some View {
        VStack {
            TextField("Enter list name", text: $newListName)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .fixedSize()
                .fontWeight(.semibold)
                .font(.largeTitle)
                .padding()
            
            TextField("Enter product name", text: $productName)
                .imageScale(.medium)
                .padding()
            Spacer()
            
            Button(action: {
                guard !productName.isEmpty else { return }
                            
                let newProduct = Product(name: productName)
                productsList.append(newProduct)
                productName = ""
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Product")
                }
            }
            .buttonStyle(BorderedButtonStyle())
            .clipShape(Capsule())
            .padding()
                        
            List {
                ForEach(productsList, id: \.self) { product in
                    HStack {
                        Image(systemName: "square")
                        Text(product.getName())
                    }
                }
            }
            .navigationTitle("Added products") //TODO: nie pokazuje tytulu
            
            Button(action: {
                let createdList = ShoppingList(name: newListName, products: productsList) //var?, czy bedzie sie zmienialo?
                //print("New list created: \(createdList.getName()) \(createdList.getProducts())")
                self.package.addList(createdList)
                //print("Lists in package after adding: \(package.getLists())")
                self.presentationMode.wrappedValue.dismiss()
            }) {
                Text("Save list")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .background(Color.green)
            .buttonStyle(BorderedButtonStyle())
            .clipShape(Capsule())
            .padding()
            
        }
        .navigationBarTitle("Create List")
    }
}

