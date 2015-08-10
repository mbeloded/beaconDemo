//
//  CategoryBannerDetailsCell.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/9/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class CategoryBannerDetailsCell: UITableViewCell {

    @IBOutlet weak var bannerView: PFImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailsLabel: UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
