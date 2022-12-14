//
//  RetryView.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 27.10.2022.
//

import SwiftUI

struct RetryView: View {
    
    let text: String
    let retryAction: () -> ()
    
    var body: some View {
        VStack(spacing: 8, content: {
            Text(text)
                .font(.callout)
                .multilineTextAlignment(.center)
            
            Button(action: retryAction) {
                Text("Refresh Page")
            }
        })
    }
}

struct RetryView_Previews: PreviewProvider {
    static var previews: some View {
        RetryView(text: "Something wrong, Try") {
        }
    }
}
