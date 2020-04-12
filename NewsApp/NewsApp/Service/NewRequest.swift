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
    var resourcesURL: [URL]
    let resourceStrings: [String]
    let API_KEY = "f16ece3fd6404846853de57f57c536db"
    var newsCategories: [NewsCategory] = []
    let defaults = UserDefaults()
    
    init() {
        
        resourceStrings = defaults.object(forKey: "Filter by categories") as? [String] ?? [String]()
        
        var resourceURL: [URL] = []
        
        if resourceStrings.isEmpty {
            resourceURL[0] = "http://newsapi.org/v2/top-headlines?sources=google-news-br&apiKey=\(API_KEY)".toURL()
            self.resourcesURL = resourceURL
        }
            
        else {
            
            for resourceString in resourceStrings {
                
                switch resourceString {
                case "Entretenimento":
                    self.newsCategories.append(CategoriesMock.entertainment)
                case "Negócios":
                    self.newsCategories.append(CategoriesMock.business)
                default:
                    print("news category not found")
                }
            }
            
            for newCategory in self.newsCategories {
                
                let resourceString = newCategory.apiURL + API_KEY
                print(resourceString)
                
                resourceURL.append(resourceString.toURL())
            }
            
            self.resourcesURL = resourceURL
        }
    }
    
    func getNews(completion: @escaping(Result<[New], NewError>) -> Void) {
        
        for newCategory in newsCategories {
            
            let dataTask = URLSession.shared.dataTask(with: (newCategory.apiURL + API_KEY).toURL()) {data, _, _ in
                
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
}
