//
//  ViewController.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 09/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: Outlet var
    @IBOutlet weak var tableView: UITableView!
    
    var mockNews: [New] = []
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        
        self.mockNews = DatabaseMock.news
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let newsNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        self.tableView.register(newsNib, forCellReuseIdentifier: "newsCell")
    }
}

// MARK: TableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mockNews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell {
            
            newsCell.categoryLabel.text = mockNews[indexPath.row].category
            newsCell.titleLabel.text = mockNews[indexPath.row].title
            newsCell.descriptionLabel.text = mockNews[indexPath.row].description
            return newsCell
        }
        
        return UITableViewCell()
    }
}

