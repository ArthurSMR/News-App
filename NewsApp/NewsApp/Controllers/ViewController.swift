//
//  ViewController.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 09/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: Variables
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
    
    /// Toolbar variables
    var _islineHorizontalButtonPressed = false
    var islineHorizontalButtonPressed: Bool {
        set {
            if newValue == false {
                self.setToolbarCountingNews()
                _islineHorizontalButtonPressed = newValue
            } else {
                self.setToolbarFiltering()
                _islineHorizontalButtonPressed = newValue
            }
        }
        get { return _islineHorizontalButtonPressed }
    }
    
    var toolbarLabel: UILabel?
    var lineHorizontalButton = UIBarButtonItem()
    var middleButton = UIBarButtonItem()
    var invisibleButton = UIBarButtonItem() //This button is just for support
    
    // MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTableView()
        self.fetchNews()
    }
    
    @objc func filterDidPressed() {
        self.performSegue(withIdentifier: "filteringVC  ", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.setupToolbar()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "showNewDetail" {
            
            if let newDetailVC = segue.destination as? NewDetailViewController {
                newDetailVC.new = self.selectedNew
            }
        }
        
        if segue.identifier == "filteringVC" {
            print("xama")
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
    
    private func setToolbarFiltering() {
        
        self.lineHorizontalButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle.fill"), style: .plain, target: self, action: #selector(changeButtonState))
        
        // This will stay on the middle of the toolbar
        self.toolbarLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  30))
        self.toolbarLabel?.text = "Filtrando por: geral"
        self.toolbarLabel?.textAlignment = .center
        
        
        let filterButton = UIButton(type: .custom)
        filterButton.frame = CGRect(x: 0, y: 0, width: self.view.frame.width * 0.7, height: 30)
        filterButton.setTitle("eai", for: .normal)
        filterButton.addTarget(self, action: #selector(self.filterDidPressed), for: .touchUpInside)
        
        self.middleButton = UIBarButtonItem(customView: filterButton)
        
        self.setToolbarItems([lineHorizontalButton, self.middleButton], animated: true)
        
    }
    
    private func setToolbarCountingNews() {
        
        self.lineHorizontalButton = UIBarButtonItem(image: UIImage(systemName: "line.horizontal.3.decrease.circle"), style: .plain, target: self, action: #selector(changeButtonState))
        
        //creating invisible button
        self.invisibleButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        self.invisibleButton.tintColor = UIColor.red.withAlphaComponent(0.0)
        
        // toolbar label for its middle button
        self.toolbarLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height:  30))
        self.toolbarLabel?.text = "\(news.count) notícias"
        self.toolbarLabel?.textAlignment = .center
        
        self.middleButton = UIBarButtonItem(customView: self.toolbarLabel ?? UILabel())
        
        self.setToolbarItems([self.lineHorizontalButton, self.middleButton, self.invisibleButton], animated: true)
    }
    
    @objc func changeButtonState() {
        self.islineHorizontalButtonPressed = !self.islineHorizontalButtonPressed
    }
    
    private func setupToolbar() {
        self.navigationController?.isToolbarHidden = false
        self.setToolbarCountingNews()
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

