//
//  NewDetailViewController.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 10/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit
import SDWebImage

class NewDetailViewController: UIViewController {
    
    var new: New?
    
    @IBOutlet weak var tableView: UITableView!
    
    
//    MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupTableView()
    }
    
//    MARK: IBActions
    @IBAction func shareButtonDidPressed(_ sender: Any) {
    
        let shareText = "Veja só essa notícia interessante que achei no ThuiNews:\n\n"
        self.shareNew(with: shareText)
    }
    
//    MARK: Private methods
    private func shareNew(with shareText: String) {
        
        guard let url = new?.url else { return }
        let shareContent: [Any] = [shareText, url]
        let activityController = UIActivityViewController(activityItems: shareContent,
                                                          applicationActivities: nil)
        self.present(activityController, animated: true, completion: nil)
    }
    
    private func setupTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        let detailNib = UINib(nibName: "NewDetailsTableViewCell", bundle: nil)
        self.tableView.register(detailNib, forCellReuseIdentifier: "detailNewCell")
        
        let imageNib = UINib(nibName: "ImageNewTableViewCell", bundle: nil)
        self.tableView.register(imageNib, forCellReuseIdentifier: "imageCell")
        
        self.tableView.estimatedRowHeight = 160
    }
    
    

}

// MARK: TableViewDelegate
extension NewDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        switch indexPath.row {
            
        case 0:
            
            if let imageCell = tableView.dequeueReusableCell(withIdentifier: "imageCell", for: indexPath) as? ImageNewTableViewCell {
                
                imageCell.newImage.sd_setImage(with: new?.urlToImage,
                                               placeholderImage: UIImage(named: "monstersInc"),
                                               options: .lowPriority,
                                               context: nil,
                                               progress: nil) { (downloadedImage, error, cacheType, url) in
                                                if let error = error {
                                                    print("Error downloading the image: \(error.localizedDescription)")
                                                } else {
                                                    print("Downloaded image")
                                                }
                }
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
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 160
    }
    
}
