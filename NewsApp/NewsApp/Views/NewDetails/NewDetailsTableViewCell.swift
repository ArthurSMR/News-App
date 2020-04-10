//
//  NewDetailsTableViewCell.swift
//  NewsApp
//
//  Created by Arthur Rodrigues on 10/04/20.
//  Copyright © 2020 Arthur Rodrigues. All rights reserved.
//

import UIKit

class NewDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
