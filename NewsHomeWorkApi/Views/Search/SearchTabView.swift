//
//  SearchTabView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 29.10.2022.
//

import SwiftUI

struct SearchTabView: View {
    
    @StateObject var searchViewModel = ArticleSearchViewModel()
    
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayViewModel)
                .navigationTitle("Поиск")
        }
        .searchable(text: $searchViewModel.searchQuery)
        .onChange(of: searchViewModel.searchQuery) { newValue in
            if newValue.isEmpty {
                searchViewModel.phase = .empty
            }
        }
        .onSubmit(of: .search, search)
    }
    
    private var articles: [Article] {
        if case .success(let articles) = searchViewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    @ViewBuilder
    private var overlayViewModel: some View {
        switch searchViewModel.phase {
        case .empty:
            if !searchViewModel.searchQuery.isEmpty {
                ProgressView()
            } else {
                EmptyPlaseholderView(text: "Введите свой запрос для поиска новостей только на английском языке", image: Image(systemName: "magnifyinglass"))
            }
            
        case .success(let articles) where articles.isEmpty:
            EmptyPlaseholderView(text: "По вашему запросу ничего не найдено", image: Image(systemName: "magnifyinglass"))
            
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: search)
            
        default: EmptyView()
        }
    }
    
    private func search() {
        Task {
            await searchViewModel.searchArticle()
        }
    }
}

struct SearchTabView_Previews: PreviewProvider {
    
    @StateObject static var boomarkViewModel = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        SearchTabView()
            .environmentObject(boomarkViewModel)
    }
}
