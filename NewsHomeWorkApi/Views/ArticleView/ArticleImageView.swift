//
//  ArticleImageView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 15.10.2022.
//

import SwiftUI

struct ArticleImageView: View {
    
    let article: Article
    
    var body: some View {
        AsyncImage(url: article.imageURL){
            phase in switch phase {
            case .empty: ProgressView()
            case .success(let image): image
                    .resizable()
                    .scaledToFill()
                    .frame(minHeight:300, maxHeight: 400)
                    .background(Color.white)
                    .clipped()
            case .failure: Image(systemName: "photo")

            @unknown default: fatalError()
            }
        }// получаем изображение
    }
}

struct ArticleImageView_Previews: PreviewProvider {
    static var previews: some View {
        ArticleImageView(article: Article.previewData[0])
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
