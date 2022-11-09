//
//  CategoryChoiseView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 02.11.2022.
//

import SwiftUI

struct CategoryChoiseView: View {
    
    let category: Category
    @StateObject var articleCategoryViewModel = ArticleCategoryViewModel()
    
    var body: some View {
        HStack {
            Button {
                toggleCategory(for: category)
            } label: {
                Text(category.name)
                
                Spacer()
                
                Image(systemName: getImageName(for: category))
                    .foregroundColor(.black)
            }.foregroundColor(.black)
        }//: HStack
    }
    
    private func getImageName(for category: Category) -> String {
        if articleCategoryViewModel.isAddToFavorites(for: category) {
            return "heart.fill"
        } else {
            return "heart"
        }
    }
    
    func toggleCategory(for category: Category) {
        if articleCategoryViewModel.isAddToFavorites(for: category) {
            articleCategoryViewModel.removeFromFavoriteCAtegories(for: category)
        } else {
            articleCategoryViewModel.addToFavoriteCategory(for: category)
        }
    }// переключатель выбора категорий
}

struct CategoryChoiseView_Previews: PreviewProvider {
    
    @StateObject var articleCategoryViewModel = ArticleCategoryViewModel()
    
    static var previews: some View {
        CategoryChoiseView(category: Category.technology)
           // .environmentObject(ArticleCategoryViewModel)
    }
}
