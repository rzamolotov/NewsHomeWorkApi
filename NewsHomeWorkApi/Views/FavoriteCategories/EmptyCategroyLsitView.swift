//
//  EmptyCategroyLsitView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 04.11.2022.
//

import SwiftUI

struct EmptyCategroyLsitView: View {
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

struct EmptyCategroyLsitView_Previews: PreviewProvider {
    static var previews: some View {
        EmptyCategroyLsitView(text: "Вы не выбрали категории", image: Image(systemName: "heart.slash.fill"))
    }
}
