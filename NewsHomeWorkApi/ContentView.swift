//
//  ContentView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 15.10.2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            NewsTabWiew()
                .tabItem {
                    Label("Новости", systemImage: "newspaper")
                }
            
            SearchTabView()
                .tabItem {
                    Label("Поиск", systemImage: "magnifyingglass")
                }
            
            BookmarkTabView()
                .tabItem {
                    Label("Избранное", systemImage: "heart")
                }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

