//
//  ArticleRowView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 15.10.2022.
//

import SwiftUI

struct ArticleRowView: View {
    
    @EnvironmentObject var articleBookmarkViewModel: ArticleBookmarkViewModel
    
    let article: Article
    @State private var selectedArticle: Article?
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: article.imageURL){
                    phase in switch phase {
                    case .empty: ProgressView()
                    case .success(let image): image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure: Image(systemName: "photo")
                        
                    @unknown default: fatalError()
                    }
                } // получаем изображение
                
                Spacer()
                
                VStack(alignment: .leading, spacing: 8, content: {
                    Text(article.title)
                        .font(.headline)
                        .lineLimit(3)
                    
                    Text(article.descriptionText)
                        .font(.subheadline)
                        .lineLimit(2)
                    
                    HStack {
                        Text(article.captitionText)
                            .lineLimit(1)
                            .foregroundColor(.secondary)
                            .font(.caption)
                        
                        Spacer()
                        
                        
                        Button {
                            toggleBookmark(for: article)
                        } label: {
                            Image(systemName: articleBookmarkViewModel.isBookmarked(for: article) ? "heart.circle.fill" : "heart.circle")
                        }
                        .buttonStyle(.bordered)
                        
                        Button {
                            presentShareSheet(url: article.articleURL)
                        } label: {
                            Image(systemName: "square.and.arrow.up")
                        }
                        .buttonStyle(.bordered)
                    }//:Hstack
                })//:Vstack
                .frame(height: 150, alignment: .bottom)
                .padding([.horizontal, .bottom])
                .background(Color.white.opacity(0.7))
                .ignoresSafeArea()
                .cornerRadius(20)
            }
        }
        .frame(minHeight: 300, maxHeight: 400)
        .background(Color.gray.opacity(0.3))
        .clipped()
        .onTapGesture { selectedArticle = article }
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
        }
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
