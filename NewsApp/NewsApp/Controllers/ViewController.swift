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
    
    var selectedNew: New?
    let refreshControl = UIRefreshControl()
    let actIndicator = UIActivityIndicatorView()
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.fetchNews()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showNewDetail" {
            
            if let newDetailVC = segue.destination as? NewDetailViewController {
                newDetailVC.new = self.selectedNew
            }
        }
    }
    // MARK: Private methods
    private func fetchNews() {
        
//      Show sppiner if there is no news
        if news.count == 0 {
            self.showSpinner(onView: self.view)
        }

        let newRequest = NewRequest()
        newRequest.getNews { [weak self] result in
            switch result {
            case .failure(let error):
                print(error)
            case .success(let news):
                self?.news = news
                self?.removeSpinner()
            }
        }
        
    }
    
    private func setupRefreshControl() {
        
        self.refreshControl.addTarget(self, action: #selector(refreshed), for: .valueChanged)
        self.tableView.refreshControl = self.refreshControl
    }
    
    @objc func refreshed() {
        self.fetchNews()
        self.refreshControl.endRefreshing()
    }
    
    private func setupTableView() {
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        //Register XIB
        let newsNib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        self.tableView.register(newsNib, forCellReuseIdentifier: "newsCell")
        
        //Creating a rerfresh control
        self.setupRefreshControl()
    }
}

// MARK: TableViewDelegate
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedNew = news[indexPath.row]
        self.performSegue(withIdentifier: "showNewDetail", sender: self)
    }
    
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

