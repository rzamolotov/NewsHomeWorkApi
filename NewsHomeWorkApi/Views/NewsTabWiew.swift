//
//  NewsTabWiew.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 27.10.2022.
//

import SwiftUI

struct NewsTabWiew: View {
    
    @StateObject var articleNewsViewModel = ArticleNewsViewModel()
        
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleNewsViewModel.fetchTaskToken, loadTask)
                .refreshable (action: refreshTask)
                .navigationTitle(articleNewsViewModel.fetchTaskToken.category.text )
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsViewModel.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaseholderView(text: "No Articles", image: nil)
        case .failure(let error):
            RetryView(text: error.localizedDescription, retryAction: refreshTask)
            
            
        default: EmptyView()
        }
    }
    
    private var articles: [Article] {
        if case let .success(articles) = articleNewsViewModel.phase {
            return articles
        } else {
            return []
        }
    }
    
    @Sendable private func loadTask() async {
            await articleNewsViewModel.loadArticles()
    }
    
    private func refreshTask() {
        articleNewsViewModel.fetchTaskToken = FetchTaskToken(category: articleNewsViewModel.fetchTaskToken.category, token: Date())
    }
        
    
    private var menu: some View {
        Menu {
            Picker("Category", selection: $articleNewsViewModel.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.text).tag($0)
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal")
                .imageScale(.large)
        }
    }
}

struct NewsTabWiew_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        NewsTabWiew(articleNewsViewModel: ArticleNewsViewModel(articles: Article.previewData))
            .environmentObject(articleBookmarkViewModel)
    }
}
