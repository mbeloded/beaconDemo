//
//  BannerView.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class BannerView: UIView {

    @IBOutlet var bannerImage:PFImageView?
    @IBOutlet var pageControl:UIPageControl?

    var mall_banner_items:Array<AnyObject>!
    var banner_items:Array<AnyObject> = []
    
    var index:Int = 0
    
    @IBOutlet weak var guest:UISwipeGestureRecognizer!
    @IBOutlet weak var guest1:UISwipeGestureRecognizer!
    
    func setupView(mall_id:String)
    {
        if guest != nil {
            self.addGestureRecognizer(guest)
        }
        
        if guest1 != nil {
            self.addGestureRecognizer(guest1)
        }
        
        mall_banner_items = CoreDataManager.sharedManager.loadData(RequestType.MALL_BANNER, key:mall_id)
        for object in mall_banner_items {
            var banners:Array<AnyObject>  = CoreDataManager.sharedManager.loadData(RequestType.BANNER, key:(object as MallBannerModel).banner_id)
            for items in banners {
                banner_items.append(items)
            }
        }
        pageControl?.numberOfPages = banner_items.count
        pageControl?.pageIndicatorTintColor = UIColor.blackColor()
        pageControl?.currentPageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            var url:NSString  = (banner_items[index] as BannerModel).image!
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath)
        }
        var timer = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: Selector("update"), userInfo: nil, repeats: true)
    }
    
    
    func update() {
        index++
        if(index >= banner_items.count)
        {
            index = 0
        }
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            //println((banner_items[0] as MallBannerModel).id)
            var url:NSString  = (banner_items[index] as BannerModel).image!
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath)
        }
    }
    
    func updateMinus() {
        index--
        if(index < 0)
        {
            index = 0
        }
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            //println((banner_items[0] as MallBannerModel).id)
            var url:NSString  = (banner_items[index] as BannerModel).image!
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath)
        }
    }

    @IBAction func rightSwipeAction(sender: AnyObject) {
        self.updateMinus()
    }
    
    @IBAction func leftSwipeAction(sender: AnyObject) {
        self.update()
    }
    
    @IBAction func pageAction(sender:AnyObject) {
        index = (sender as UIPageControl).currentPage
        pageControl?.currentPage = index
        if(banner_items.count > 0)
        {
            //println((banner_items[0] as MallBannerModel).id)
            var url:NSString  = (banner_items[index] as BannerModel).image!
            var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(url.lastPathComponent)");
            bannerImage?.image = UIImage(named: pngPath)
        }
    }
}
