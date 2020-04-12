//
//  FilterViewController.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 12/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

protocol CategoriesFilterDelegate {
    func didModify(filterByCategories: [String])
}

class FilterViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var categories: [NewsCategory] = []
    
    var filterByCategories: [String] = []
    let defaults = UserDefaults.standard
    
    var delegate: CategoriesFilterDelegate?
    var selectedFilterChanged: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.categories = CategoriesMock.allCategories
        
        self.filterByCategories = self.defaults.object(forKey: "Filter by categories") as? [String] ?? [String]()
        
        self.setupTableView()
        
    }
    
    @IBAction func didOKbuttonPressed(_ sender: UIBarButtonItem) {
        
        self.defaults.set(self.filterByCategories, forKey: "Filter by categories")
        
        guard self.selectedFilterChanged else {
            self.dismiss(animated: true, completion: nil)
            print(selectedFilterChanged)
            return
        }
        print(selectedFilterChanged)
        self.delegate?.didModify(filterByCategories: self.filterByCategories)
        self.dismiss(animated: true, completion: nil)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "incluir notícias de:"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let categorySelected = self.categories[indexPath.row].name
        self.selectedFilterChanged = true
        
        if self.filterByCategories.contains(categorySelected) {
            
            let deselectCategory = self.filterByCategories.filter {$0 != categorySelected}
            
            self.filterByCategories = deselectCategory
            self.tableView.reloadData()
        }
        else  {
            self.filterByCategories.append(self.categories[indexPath.row].name)
            
            self.tableView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        self.categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let categoryCell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as? UITableViewCell {
            
            if filterByCategories.contains(self.categories[indexPath.row].name) {
                categoryCell.accessoryType = .checkmark
            }
            else {
                categoryCell.accessoryType = .none
            }
            
            categoryCell.textLabel?.text = self.categories[indexPath.row].name
            categoryCell.imageView?.image = self.categories[indexPath.row].iconImage.image
            return categoryCell
        }
        
        return UITableViewCell()
        
    }
}
