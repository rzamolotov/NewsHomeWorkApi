//
//  BookmarkTabView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 29.10.2022.
//

import SwiftUI

struct BookmarkTabView: View {
    
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    @State var searchText: String = ""
    
    var body: some View {
        let articles = self.articles
        
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView(isEmpty: articles.isEmpty))
                .navigationTitle("Favorite Articles")
        }
        .searchable(text: $searchText)
    }
    
    private var articles: [Article] {
        if searchText.isEmpty {
            return articleBookmarkViewModel.bookmarks
        }
        return articleBookmarkViewModel.bookmarks
            .filter{
                $0.title.lowercased().contains(searchText.lowercased()) ||
                $0.descriptionText.lowercased().contains(searchText.lowercased())
            }
    }
    
    @ViewBuilder
    func overlayView(isEmpty: Bool) -> some View {
        if isEmpty {
            EmptyPlaseholderView(text: "You Don`t Add Articles, Yet", image: Image(systemName: "heart.slash.fill"))
        }
    }
}

struct BookmarkTabView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        BookmarkTabView()
            .environmentObject(articleBookmarkViewModel)
    }
}
