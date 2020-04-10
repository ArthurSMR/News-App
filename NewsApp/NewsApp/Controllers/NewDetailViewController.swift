//
//  NewDetailViewController.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 10/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

class NewDetailViewController: UIViewController {
    
    var new: New?
    
    @IBOutlet weak var tableView: UITableView!
    
    var imageRect: CGRect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
        
        
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let detailNib = UINib(nibName: "NewDetailsTableViewCell", bundle: nil)
        self.tableView.register(detailNib, forCellReuseIdentifier: "detailNewCell")
        
        let imageNib = UINib(nibName: "ImageNewTableViewCell", bundle: nil)
        self.tableView.register(imageNib, forCellReuseIdentifier: "imageCell")
    }
    
}

extension NewDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
            
        case 0:
            
            if let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageNewTableViewCell {
                
                imageCell.newImage.load(url: (new?.urlToImage)!)
                
                
                return imageCell
            }
        case 1:
            
            if let detailCell = tableView.dequeueReusableCell(withIdentifier: "detailNewCell", for: indexPath) as? NewDetailsTableViewCell {
                
                detailCell.titleLabel.text = new?.title
                detailCell.descriptionLabel.text = new?.description
                detailCell.authorLabel.text = new?.author
                detailCell.contentLabel.text = new?.content
                return detailCell
            }
        default:
            print("indexpath not found")
        }
        
        return UITableViewCell()
    }
    
    
}
