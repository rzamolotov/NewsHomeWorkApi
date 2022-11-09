//
//  CategoryTabView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 04.11.2022.
//

import SwiftUI

struct CategoryTabView: View {
    
    @EnvironmentObject var articleCategoryViewModel: ArticleCategoryViewModel
    
    let category: Category
    
    var body: some View {
        EmptyCategroyLsitView(text: "Вы не выбрали категории", image: Image(systemName: "heart.slash.fill"))
    }
}

struct CategoryTabView_Previews: PreviewProvider {
    
    @StateObject static var articleCategoryViewModel = ArticleCategoryViewModel.shared
    
    static var previews: some View {
        CategoryTabView(category: Category.business)
            .environmentObject(articleCategoryViewModel)
    }
}
