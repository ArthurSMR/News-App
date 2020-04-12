//
//  String+URL.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 12/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import Foundation

extension String {
    
    func toURL() -> URL {
        
        guard let resourceURL = URL(string: self) else {fatalError()}
        
        return resourceURL
    }
}
