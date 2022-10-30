//
//  ImageFetcher.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 17.10.2022.
//

import Foundation
import SwiftUI
import Combine

class ImageFetcher: ObservableObject {
    var didChnge = PassthroughSubject<Data, Never>()
    
    var data: Data = Data() {
        didSet {
            didChnge.send(data)
        }
    }
    
    init(urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async { [weak self] in
                self?.data = data
            }
        }.resume()
    }
}
