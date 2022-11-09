//
//  NewsTabWiew.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 27.10.2022.
//

import SwiftUI

struct NewsTabWiew: View {
    
    @StateObject var articleNewsViewModel = ArticleNewsViewModel()
    @StateObject var articleCategoryViewModel = ArticleCategoryViewModel()
    let category: Category
        
    var body: some View {
        NavigationView {
            ArticleListView(articles: articles)
                .overlay(overlayView)
                .task(id: articleNewsViewModel.fetchTaskToken, loadTask)
                .refreshable (action: refreshTask)
                .navigationTitle(articleNewsViewModel.fetchTaskToken.category.name )
                .navigationBarItems(trailing: menu)
        }
    }
    
    @ViewBuilder
    private var overlayView: some View {
        switch articleNewsViewModel.phase {
        case .empty:
            ProgressView()
        case .success(let articles) where articles.isEmpty:
            EmptyPlaseholderView(text: "Новостей не найдено", image: nil)
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
    }//функция асинхронной загрузки новостей
    
    private func refreshTask() {
        Task {
            await articleNewsViewModel.refrechTask()
        }
    } //функция обновления станицы
        
    
    private var menu: some View {
        Menu {
            Picker("Категории", selection: $articleNewsViewModel.fetchTaskToken.category) {
                ForEach(Category.allCases) {
                    Text($0.name).tag($0)
                }
            }
        } label: {
            Image(systemName: "line.3.horizontal")
                .imageScale(.large)
        }
    } //кнопка меню
}

struct NewsTabWiew_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    @StateObject static var articleCategoryViewModel = ArticleCategoryViewModel.shared
    
    static var previews: some View {
        NewsTabWiew(category: Category.general)
            .environmentObject(articleBookmarkViewModel)
            .environmentObject(articleCategoryViewModel)
    }
}
