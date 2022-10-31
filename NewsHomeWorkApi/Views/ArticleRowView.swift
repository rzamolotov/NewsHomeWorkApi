//
//  ArticleRowView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 15.10.2022.
//

import SwiftUI

struct ArticleRowView: View {
    
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    @State private var selectedArticle: Article?
    let article: Article
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                ArticleImageView(article: article)
                
                TextArticleView(article: article)
            }
        }
        .onTapGesture { selectedArticle = article }
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL) //переход по ссылке по нажатию на новость
        }
    }
}

struct ArticleRowView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        NavigationView{
            List {
                ArticleRowView(article: Article.previewData[0])
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
            }
            .listStyle(.plain)
        }
        .environmentObject(articleBookmarkViewModel)
    }
}
