//
//  MainMenuView.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

let cellIdent = "MainCellID"

class MainMenuView: UIView, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var collectionView: UICollectionView!
    
    var selectedIndex:Int = 0
    var items:Array<AnyObject> = []
    var owner:UIViewController!
    var category_id:String!
    
    func setupView()
    {
        items = CoreDataManager.sharedManager.loadData(RequestType.CATEGORY)
        collectionView.reloadData()
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return items.count
    }
    
    // The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell
    {
        var cell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdent, forIndexPath: indexPath) as MainCollectionViewCell
        cell.backgroundColor = UIColor.clearColor()
        var category = items[indexPath.row] as CategoryModel
        cell.category = category
        cell.nameLabel.text = (items[indexPath.row] as CategoryModel).name
        return cell
    }
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumInteritemSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 1.0
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        minimumLineSpacingForSectionAtIndex section: Int) -> CGFloat
    {
        return 1.0
    }
    
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        insetForSectionAtIndex section: Int) -> UIEdgeInsets
    {
        return UIEdgeInsetsMake(0, 0, 0, 0)
    }
    
    func collectionView(collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize
    {
        return CGSizeMake(self.frame.size.width/3 - 3 , self.frame.size.width/3 - 3)
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath)
    {
        selectedIndex = indexPath.row
        var category = items[indexPath.row] as CategoryModel
        category_id = category.id
        owner?.performSegueWithIdentifier("showCategory", sender: owner)
    }
}
