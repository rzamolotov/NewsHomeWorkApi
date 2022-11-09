//
//  ArticleNewsViewModel.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 22.10.2022.
//

import SwiftUI

enum DataFetchPhase<T> {
    case empty
    case success(T)
    case failure(Error)
} // перечисление типов получения данных

struct FetchTaskToken: Equatable {
    var category: Category
    var token: Date
} 

@MainActor
class ArticleNewsViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskToken: FetchTaskToken
    private let newsAPI = NewsAPI.shared
    private let cache = DiskCache<[Article]>(filename: "home_work_api", expirationInterval: 3 * 60)
    
    
    init(articles: [Article]? = nil, selectedCategory: Category = .general) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskToken = FetchTaskToken(category: selectedCategory, token: Date())
        
        Task(priority: .userInitiated){
            try? await cache.loadFromDisk()
        }
    }
    
    func refrechTask() async {
        await cache.removeValue(forKey: fetchTaskToken.category.rawValue)
        fetchTaskToken.token = Date()
    }
    
    func loadArticles() async {
        if Task.isCancelled { return } //если задача загрузки артиклуов отменена вызываем прерываем загрузку артикулов
        let category = fetchTaskToken.category
        if let articles = await cache.value(forKey: category.rawValue) {
            phase = .success(articles)
            print("CACHE HIT")
            return
        }
        
        print("CACHE MISSED/EXPIRED")
        phase = .empty
        do  {
            let articles = try await newsAPI.fetch(from: fetchTaskToken.category)
            if Task.isCancelled { return }
            await cache.setValue(articles, forKey: category.rawValue)
            try? await cache.saveToDisk()
            
            print("CACHE SET")
            phase = .success(articles)
        }  catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    } //функция загрузки новостей
}
