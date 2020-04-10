//
//  DatabaseMock.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 09/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

class DatabaseMock {
    
    static var news: [New] {
        
        var arr: [New] = []
        
        let new1 = New(title: "Na TV, Doria diz que pessoas podem ser presas se isolamento não for respeitado", description: "Bolsonaro e empresários defendem reabertura de comércio, fechados devido ao coronavírus", category: "pandemia")
        arr.append(new1)
        
        let new2 = New(title: "Brasil tem 141 novas mortes por coronavírus nas últimas 24 horas; total é 941", description: "País tem 17.857 casos; número real tende a ser maior", category: "pandemia")
        arr.append(new2)
        
        let new3 = New(title: "Osmar  Terra oferece ajuda a Onyx para trocar Mandetta", description: "'Eu só trabalho, deixa eles'", category: "em diálogo")
        arr.append(new3)
        
        return arr
    }
    
}
