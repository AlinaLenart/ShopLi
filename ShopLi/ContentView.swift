//
//  ContentView.swift
//  ShopLi
//
//  Created by Alina Lenart on 30/04/2024.
//

import Foundation
import SwiftUI

struct ContentView: View {
    @State private var newListName = ""
    @State private var package = Package()
    @State private var showingCreateListView = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(package.getLists()) { list in
                        Section(header: Text(list.getName())) {
                            ForEach(list.getProducts()) { product in
                                Text(product.getName())
                            }
                        }
                    }
                }
                .navigationTitle("Lists")
                .listStyle(.grouped)
            }
            .navigationBarItems(trailing:
                Button(action: {
                showingCreateListView = true
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showingCreateListView) {
            
                CreateListView(package: package)
                
            }
        }
        /*.onAppear {
            testPackage(package)
        }*/
    }
}

func testPackage(_ package: Package) {
    print("---Lists:")
    if package.getLists().isEmpty {
        print("Package is empty")
    }
    else {
        for list in package.getLists() {
            print(list.getName())
            for product in list.getProducts() {
                print(product.getName())
            }
        }
    }
        
}

//struct ContentView: View {
//    @State private var newListName = ""
//    @State private var package = Package()
//    @State private var showingCreateListView = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                List {
//                    ForEach(package.getLists()) { list in
//                        Section(header: Text(list.getName())) {
//                            ForEach(list.getProducts()) { product in
//                                Text(product.getName())
//                            }
//                        }
//                    }
//                }
//                .listStyle(GroupedListStyle())
//
//                Spacer()
//
//                Button(action: {
//                    showingCreateListView = true
//                }) {
//                    Image(systemName: "plus")
//                        .imageScale(.large)
//                        .foregroundColor(.accentColor)
//                        .frame(width: 44, height: 44)
//                }
//                .padding()
//            }
//            .navigationBarTitle("Lists")
//            .navigationBarItems(trailing: EditButton())
//            .sheet(isPresented: $showingCreateListView) {
//                CreateListView(package: package)
//            }
//        }
//    }
//}
