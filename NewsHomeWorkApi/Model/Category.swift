//
//  Category.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 20.10.2022.
//

import Foundation

enum Category: String, CaseIterable {
    case general
    case business
    case technology
    case entertainment
    case sports
    case science
    case health
    
    var name: String {
        if self == .general {
            return "General"
        } else if self == .business {
            return "Business"
        } else if self == .technology {
            return "Technology"
        } else if self == .entertainment {
            return "Entertainment"
        } else if self == .sports {
            return "Sports"
        } else if self == .science {
            return "Science"
        } else if self == .health {
            return "Health"
        }
    return rawValue.capitalized
    }
} //перечисляем категории и даем им название

extension Category: Identifiable {
    var id: Self { self }
}
extension Category: Codable {}
extension Category: Equatable {}

struct CategoryAPIResponse: Decodable {
    
    let status: String
    let totalResults: Int?
    let category: [Category]?
}
