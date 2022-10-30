//
//  NewsAPIResponse.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 15.10.2022.
//

import Foundation
 
struct NewsAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let articles: [Article]?
    
    let code: String?
    let message: String?
}
