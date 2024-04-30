//
//  ContentView.swift
//  ShopLi
//
//  Created by Alina Lenart on 30/04/2024.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Lists", systemImage: "list.dash")
                }
            AddView()
                .tabItem {
                    Label("Add new", systemImage: "square.and.pencil")
                }
        }
    }
}


#Preview {
    ContentView()
}
