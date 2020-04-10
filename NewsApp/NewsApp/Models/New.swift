//
//  New.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 09/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

struct ArticlesResponse: Decodable {
    var articles: [New]
}

struct New: Decodable {
    var source: SourceDetail
    var author: String?
    var title: String?
    var description: String?
    var content: String?
    var urlToImage: URL?
}

struct SourceDetail: Decodable {
    var name: String
}
