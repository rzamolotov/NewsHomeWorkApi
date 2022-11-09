//
//  CategoryListView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 04.11.2022.
//

import SwiftUI

struct CategoryListView: View {
    
    let category: [Category]
    @State private var selectedCategory: Category?
    
    var body: some View {
        NavigationView{
            ScrollView{
                VStack (alignment: .center, spacing: 12) {
                    ForEach (category) { category in
                        CategoryChoiseView(category: category)
                            .padding()
                        }
                    Spacer()
                    
                    NavigationLink("Показать выбраные категории", destination: CategoryTabView(category: Category.business))
                    .buttonStyle(.bordered)
                    .font(.headline)
                }
            }
            .navigationTitle("Выбор категорий")
        }
    }
}

struct CategoryListView_Previews: PreviewProvider {
    
    @StateObject static var articleCategoryViewModel = ArticleCategoryViewModel.shared
    
    static var previews: some View {
        CategoryListView(category: Category.allCases)
            .environmentObject(articleCategoryViewModel)
    }
}
