//
//  TextArticleView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 15.10.2022.
//

import SwiftUI

struct TextArticleView: View {
    
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    
    let article: Article
    
    var body: some View {
        VStack(alignment: .leading, spacing: 5, content: {
            Text(article.title)
                .font(.headline)
                .lineLimit(1) //заголовок
            
            Text(article.descriptionText)
                .font(.subheadline)
                .lineLimit(3) //описание статьи
            
            HStack {
                Text(article.captitionText)
                    .lineLimit(1)
                    .foregroundColor(.secondary)
                    .font(.caption) // дата и время статьи
                
                Spacer()
                
                Button {
                    toggleBookmark(for: article)
                } label: {
                    Image(systemName: articleBookmarkViewModel.isBookmarked(for: article) ? "heart" : "heart.fill")
                        .foregroundColor(.black)
                } //кнопка избранное
                .buttonStyle(.bordered)
                
                Button {
                    presentShareSheet(url: article.articleURL)
                } label: {
                    Image(systemName: "square.and.arrow.up")
                        .foregroundColor(.black)
                } // кнопка поделиться
                .buttonStyle(.bordered)
            }//:Hstack
        })//:Vstack
        .frame(width: UIScreen.screenWidth * 0.9, height: 120,  alignment: .bottom)
        .padding([.horizontal, .bottom])
        .background(Color.white.opacity(0.8))
        .ignoresSafeArea()
        .cornerRadius(20)
    }
    private func toggleBookmark(for article: Article) {
        if articleBookmarkViewModel.isBookmarked(for: article) {
            articleBookmarkViewModel.removeBookmark(for: article)
        } else {
            articleBookmarkViewModel.addBookmark(for: article)
        }
    }//функция которая проверяет нажата ли кнопка избранного или нет
}

extension View {
    func presentShareSheet(url: URL) {
        let activityVC = UIActivityViewController(activityItems: [url], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    } //функция поделиться
}

extension UIScreen{
   static let screenWidth = UIScreen.main.bounds.size.width
} //получаем размер экрана для отображения вью

struct TextArticleView_Previews: PreviewProvider {
    
    @StateObject static var articleBookmarkViewModel = ArticleBookmarkViewModel.shared
    
    static var previews: some View {
        TextArticleView(article: Article.previewData[0])
            .environmentObject(articleBookmarkViewModel)
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
