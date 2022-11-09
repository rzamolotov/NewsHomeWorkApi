//
//  ArticleCategoryViewModel.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 31.10.2022.
//

import SwiftUI

@MainActor
class ArticleCategoryViewModel: ObservableObject {
    
    @Published private(set) var favoriteCategories: [Category] = []
    let favoriteCategoriesStore = PlistDataStore<[Category]>(filename: "favoriteCategories")
    
    static let shared = ArticleCategoryViewModel()
    init() {
        Task {
            await load()
        }
    }
    
    private func load() async {
       favoriteCategories = await favoriteCategoriesStore.load() ?? []
    } //загрузка избранных категорий
    
    func isAddToFavorites(for category: Category) -> Bool{
        favoriteCategories.first { category.id == $0.id } != nil
    } //проверяем добавлена ли категория в избранное
    
    func addToFavoriteCategory(for category: Category) {
        guard !isAddToFavorites(for: category) else {
            return
        }
        favoriteCategories.insert(category, at: 0)
        categoryUpdated()
    } //Функция добавления в избранное категории
    
    func removeFromFavoriteCAtegories(for category: Category) {
        guard let index = favoriteCategories.firstIndex(where: { $0.id == category.id }) else {
            return
        }
        favoriteCategories.remove(at: index)
        categoryUpdated()
    } //удаление закладки при нажатии на переключатель
    
    private func categoryUpdated() {
        let favoriteCategories = self.favoriteCategories
        Task {
            await favoriteCategoriesStore.save(favoriteCategories)
        }
    }
}
