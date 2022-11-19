//
//  ArticleBookmarkViewModel.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 29.10.2022.
//

import SwiftUI

@MainActor
class ArticleBookmarkViewModel: ObservableObject {
    
    @Published private(set) var bookmarks: [Article] = []
    private let bookmarkStore = PlistDataStore<[Article]>(filename: "favorites")
    
    static let shared = ArticleBookmarkViewModel()
    private init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
        bookmarks = await bookmarkStore.load() ?? []
    } //загрузка избранных
    
    func isBookmarked(for article: Article) -> Bool{
        bookmarks.first { article.id == $0.id } != nil
    } //проверяем добавлена ли статья в избранное
    
    func addBookmark(for article: Article) {
        guard !isBookmarked(for: article) else {
            return
        }
        bookmarks.insert(article, at: 0)
        bookmarkUpdated()
    } //Функция добавления в избранное
    
    func removeBookmark(for article: Article) {
        guard let index = bookmarks.firstIndex(where: { $0.id == article.id }) else {
            return
        }
        bookmarks.remove(at: index)
        bookmarkUpdated()
    } //удаление закладки при нажатии на сердечко
    
    private func bookmarkUpdated() {
        let bookmarks = self.bookmarks
        Task {
            await bookmarkStore.save(bookmarks)
        }
    }//обновляем список избранных
    
}
