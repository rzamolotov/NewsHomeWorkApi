//
//  NewsHomeWorkApiApp.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 15.10.2022.
//

import SwiftUI

@main
struct NewsHomeWorkApiApp: App {
    
    @StateObject var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(articleBookmarkViewModel)
        }
    }
}
