//
//  CategoryChoiseView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 02.11.2022.
//

import SwiftUI

struct CategoryChoiseView: View {
    
    let category: Category
    @EnvironmentObject var articleCategoryViewModel: ArticleCategoryViewModel
    
    var body: some View {
        HStack {
            Text(category.name)
            
            Spacer()
            
            Button {
                toggleCategory(for: category)
            } label: {
                Image(systemName: articleCategoryViewModel.isAddToFavorites(for: category) ? "heart.fill" : "heart")
                    .foregroundColor(.black)
            }
        }//: HStack
    }
    private func toggleCategory(for category: Category) {
        if articleCategoryViewModel.isAddToFavorites(for: category) {
            articleCategoryViewModel.removeFromFavoriteCAtegories(for: category)
        } else {
            articleCategoryViewModel.addToFavoriteCategory(for: category)
        }
    }// переключатель выбора категорий
}

struct CategoryChoiseView_Previews: PreviewProvider {
    
    @StateObject static var articleCategoryViewModel = ArticleCategoryViewModel.shared
    
    static var previews: some View {
        CategoryChoiseView(category: Category.technology)
            .environmentObject(articleCategoryViewModel)
    }
}
