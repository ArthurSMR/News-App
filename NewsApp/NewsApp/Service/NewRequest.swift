//
//  NewRequest.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 09/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Foundation

enum NewError: Error {
    case noDataAvailable
    case canNotProcessData
}

struct NewRequest {
    let resourceURL: URL
    let API_KEY = "f16ece3fd6404846853de57f57c536db"
    
    init() {
        let resourceString = "http://newsapi.org/v2/top-headlines?sources=google-news-br&apiKey=\(API_KEY)"
        
        guard let resourceURL = URL(string: resourceString) else {fatalError()}
        
        self.resourceURL = resourceURL
    }
    
    func getNews(completion: @escaping(Result<[New], NewError>) -> Void) {
        
        let dataTask = URLSession.shared.dataTask(with: resourceURL) {data, _, _ in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                let articlesResponse = try decoder.decode(ArticlesResponse.self, from: jsonData)
                let newDetails = articlesResponse.articles
                completion(.success(newDetails))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
        
    }
}
