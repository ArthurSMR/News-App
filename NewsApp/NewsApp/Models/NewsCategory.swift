//
//  Category.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 12/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

class NewsCategory {
    
    let name: String
    var apiURL: String
    let iconImage: UIImageView
    
    init(name: String, apiURL: String, iconImage: UIImageView) {
        self.name = name
        self.apiURL = apiURL
        self.iconImage = iconImage
    }
}
