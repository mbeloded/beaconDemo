//
//  MainCollectionViewCell.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class MainCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var nameLabel: UILabel! {
        didSet {
            println(nameLabel.text)
        }
    }
    @IBOutlet weak var imageView: PFImageView!
    
    var category:CategoryModel! {
        didSet {
            nameLabel.text = category.name
            var url:NSString  = category.icon!
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            imageView.image = UIImage(named: pngPath)
            imageView.backgroundColor = UIColor.blackColor()
            imageView.layer.cornerRadius = imageView.frame.size.width/2;

        
        }
    }
    override func drawRect(rect: CGRect) {
        imageView.frame = CGRectMake(0, 0, self.frame.size.width/1.5, self.frame.size.width/1.5)
        imageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2.8)
        imageView.layer.cornerRadius = imageView.frame.size.width/2;
    }
}
