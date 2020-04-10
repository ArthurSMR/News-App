//
//  UIImageView+LoadURL.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 10/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                        print(self?.image?.size)
                        print("loaded image with url: \(url)")
                    }
                }
            }
        }
    }
}
