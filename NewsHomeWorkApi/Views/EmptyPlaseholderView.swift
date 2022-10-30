//
//  EmptyPlaseholderView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 27.10.2022.
//

import SwiftUI

struct EmptyPlaseholderView: View {
    let text: String
    let image: Image?
    
    var body: some View {
        VStack(spacing: 8) {
            Spacer()
            if let image = self.image {
                image
                    .imageScale(.large)
                    .font(.system(size: 52))
            }
            Text(text)
            Spacer()
        }
    }
}

struct EmptyPlaseholderView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyPlaseholderView(text: "Нет избранных статей", image: Image(systemName: "heart.slash.fill"))
    }
}
