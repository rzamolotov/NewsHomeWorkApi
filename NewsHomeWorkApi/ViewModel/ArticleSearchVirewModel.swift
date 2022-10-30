//
//  ArticleSearchVirewModel.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 29.10.2022.
//

import SwiftUI

@MainActor
class ArticleSearchViewModel: ObservableObject {
    
    @Published var phase: DataFetchPhase<[Article]> = .empty
    @Published var searchQuery = ""
    private let newsAPI = NewsAPI.shared
    
    func searchArticle() async {
        if Task.isCancelled { return }
        
        let searchQuery = self.searchQuery.trimmingCharacters(in: .whitespacesAndNewlines)
        phase = .empty
        
        if searchQuery.isEmpty {
            return
        }
        
        do {
            let articles = try await newsAPI.search(for: searchQuery)
            if Task.isCancelled { return }
            phase = .success(articles)
        } catch {
            if Task.isCancelled { return }
            phase = .failure(error)
        }
        
    }
    
}
