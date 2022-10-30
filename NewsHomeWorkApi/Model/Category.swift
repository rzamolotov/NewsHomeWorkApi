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
    
    var text: String {
        if self == .general {
            return "Главное"
        } else if self == .business {
            return "Бизнес"
        } else if self == .technology {
            return "Технологии"
        } else if self == .entertainment {
            return "Развлечения"
        } else if self == .sports {
            return "Спорт"
        } else if self == .science {
            return "Наука"
        } else if self == .health {
            return "Здоровье"
        }
    return rawValue.capitalized
    }
} //перечисляем категории и даем им название

extension Category: Identifiable {
    var id: Self { self }
}
