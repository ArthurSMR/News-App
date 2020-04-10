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
    
    var news: [New] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.fetchNews()
        //self.mockNews = DatabaseMock.news
    }
    
    private func fetchNews() {
        let newRequest = NewRequest()
        newRequest.getNews { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let news):
                self?.news = news
        }
    }
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
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let newsCell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for: indexPath) as? NewsTableViewCell {
            
            newsCell.titleLabel.text = news[indexPath.row].title
            newsCell.descriptionLabel.text = news[indexPath.row].description
            return newsCell
        }
        
        return UITableViewCell()
    }
}

