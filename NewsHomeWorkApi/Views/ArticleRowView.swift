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
        VStack(alignment: .leading, spacing: 16, content: {
            HStack {
                Spacer()
                AsyncImage(url: article.imageURL){
                    phase in switch phase {
                    case .empty: ProgressView()
                    case .success(let image): image
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                        
                    case .failure: Image(systemName: "photo")
                        
                    @unknown default: fatalError()
                        
                    }
                }
                .frame(minHeight: 200, maxHeight: 300)
                Spacer()
            }
        })

        .frame(minHeight: 200, maxHeight: 300)
        .background(Color.gray.opacity(0.3))
        .clipped()
        .onTapGesture { selectedArticle = article }
        .sheet(item: $selectedArticle) {
            SafariView(url: $0.articleURL)
        }
    
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
            }
        })
        .padding([.horizontal, .bottom])
    }
    private func toggleBookmark(for article: Article) {
        if articleBookmarkViewModel.isBookmarked(for: article) {
            articleBookmarkViewModel.removeBookmark(for: article)
        } else {
            articleBookmarkViewModel.addBookmark(for: article)
        }
    }
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
