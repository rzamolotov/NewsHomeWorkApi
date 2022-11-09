//
//  FavoriteCategoryViewModel.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 06.11.2022.
//

import SwiftUI

enum DataFetchCategoryPhase<T> {
    case empty
    case success(T)
    case failure(Error)
} // перечисление типов получения данных

struct FetchTaskCateforyToken: Equatable {
    var category: Category
    var token: Date
} //получение токена задачи

@MainActor
class FavoriteChanelCategoryViewModel: ObservableObject {
    
    @Published var phase = DataFetchPhase<[Article]>.empty
    @Published var fetchTaskCategoryToken: FetchTaskCateforyToken
    private let newsAPI = NewsAPI.shared
    
    init(articles: [Article]? = nil, selectedCategory: Category = .health) {
        if let articles = articles {
            self.phase = .success(articles)
        } else {
            self.phase = .empty
        }
        self.fetchTaskCategoryToken = FetchTaskCateforyToken(category: selectedCategory, token: Date())
    }
    
    func loadArticles() async {
        if Task.isCancelled { return } //если задача загрузки артиклуов отменена вызываем прерываем загрузку артикулов
        phase = .empty
        do  {
            let articles = try await newsAPI.fetchCategory(from: fetchTaskCategoryToken.category)
            if Task.isCancelled { return }
            phase = .success(articles)
        }  catch {
            if Task.isCancelled { return }
            print(error.localizedDescription)
            phase = .failure(error)
        }
    } //функция загрузки новостей
}
