//
//  NewsAPI.swift
//  NewsHomeWorkApi
//
//  Created by Роман Замолотов on 20.10.2022.
//

import Foundation

struct NewsAPI {
    
    static let shared = NewsAPI()
    private init() {}
    
    private let apiKey = "6ff3aa7e72554b3eaf9f4b764aadb7ed"
    private let session = URLSession.shared
    private let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()
    
    private func generateNewsURL(from category: Category) -> URL {
        var url = "https://newsapi.org/v2/top-headlines?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&category=\(category.rawValue)"
        return URL(string: url)!
    } // создаем URL для получения данных из API
    
    func generateSearchURL(from query: String) -> URL {
        let percentEncodedString = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? query
        
        var url = "https://newsapi.org/v2/everything?"
        url += "apiKey=\(apiKey)"
        url += "&language=en"
        url += "&q=\(percentEncodedString)"
        return URL(string: url)!
    } //создаем поисковый запрос, главный вопрос, как он делается на русском?
    
    func fetch(from category: Category) async throws -> [Article] {
        try await fetchArticles(from: generateNewsURL(from: category))
    } //функция получения новостей с API
    
    func search(for query: String) async throws -> [Article] {
        try await fetchArticles(from: generateSearchURL(from: query))
    } //функция поиска новостей, в массиве данных
    
    private func fetchArticles(from url:URL) async throws -> [Article] {
        let (data, response) = try await session.data(from: url)
       
        guard let response = response as? HTTPURLResponse else {
            throw generateError(description: "Ошибка ответа сервера")
        } //если не получаем ответ при запросе получаем ошибку сервера
        
        switch response.statusCode {
        case (200...299), (400...499):
            let apiResponse = try jsonDecoder.decode(NewsAPIResponse.self, from: data)
            if apiResponse.status == "ok" {
                return apiResponse.articles ?? []
            } else {
                throw generateError(description: apiResponse.message ?? "Произошла ошибка сервера")
            }
        default:
            throw generateError(description: "Произошла ошибка сервера")
        } //генерируем ошибки
    }
    
    private func generateError(code: Int = 1, description: String) -> Error {
        NSError(domain: "NewsAPI", code: code, userInfo: [NSLocalizedDescriptionKey: description])
    } //создаем ошибку
}
