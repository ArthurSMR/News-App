//
//  DatabaseMock.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 09/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

class CategoriesMock {

//        static var news: [New] {
//
//            var arr: [New] = []
//
//            let new1 = New(title: "Na TV, Doria diz que pessoas podem ser presas se isolamento não for respeitado", description: "Bolsonaro e empresários defendem reabertura de comércio, fechados devido ao coronavírus")
//            arr.append(new1)
//
//            let new2 = New(title: "Brasil tem 141 novas mortes por coronavírus nas últimas 24 horas; total é 941", description: "País tem 17.857 casos; número real tende a ser maior")
//            arr.append(new2)
//
//            let new3 = New(title: "Osmar  Terra oferece ajuda a Onyx para trocar Mandetta", description: "'Eu só trabalho, deixa eles'")
//            arr.append(new3)
//
//            return arr
//        }
    
    static var entertainment: NewsCategory {
        
        let entertainmentURL = "http://newsapi.org/v2/top-headlines?country=br&category=entertainment&apiKey="
        
        let imageViewEnt = UIImageView()
        imageViewEnt.image = UIImage(named: "entertainment")
        
        let entertainment = NewsCategory(name: "Entretenimento", apiURL: entertainmentURL, iconImage: imageViewEnt)

        return entertainment
        
    }
    
    static var business : NewsCategory {
        
        let imageViewBus = UIImageView()
        imageViewBus.image = UIImage(named: "business")
        
        let businessURL = "http://newsapi.org/v2/top-headlines?country=br&category=business&apiKey="
        let business = NewsCategory(name: "Negócios", apiURL: businessURL, iconImage: imageViewBus)
        
        return business
    }
}
