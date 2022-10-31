//
//  CategoryTabView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 31.10.2022.
//

import SwiftUI

struct CategoryTabView: View {
    
    @StateObject var articleNewsViewModel = ArticleNewsViewModel()
    
    var body: some View {
        List{
            ForEach(Category.allCases) {
                Text($0.text).tag($0)
            }
        }
    }
}

struct CategoryTabView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryTabView(articleNewsViewModel: ArticleNewsViewModel(articles: Article.previewData))
    }
}
