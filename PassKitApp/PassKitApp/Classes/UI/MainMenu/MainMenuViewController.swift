//
//  MainMenuViewController.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class MainMenuViewController: RootViewController {

    @IBOutlet weak var mainMenuView: MainMenuView!
    @IBOutlet weak var bannerView: BannerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainMenuView.owner = self
        mainMenuView.setupView()
        
        var items:Array<AnyObject> = CoreDataManager.sharedManager.loadData(RequestType.MALL)
        if(items.count > 0)
        {
            var mallModel:MallModel = items[0] as MallModel
            self.title = mallModel.name
            bannerView.setupView(mallModel.id)
            
        }
        self.hideLeftButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        if(segue.identifier == "showCategory")
        {
            let viewController:CategoryViewController = segue.destinationViewController as CategoryViewController
            var items:Array<AnyObject> = CoreDataManager.sharedManager.loadData(RequestType.MALL)
            if(items.count > 0)
            {
                var mallModel:MallModel = items[0] as MallModel
                viewController.mall_id = mallModel.id
                viewController.category_id = mainMenuView.category_id
                
            }
        }
    }

    @IBAction func rightSwipeAction(sender: AnyObject) {
        bannerView.update()
    }
    
    @IBAction func leftSwipeAction(sender: AnyObject) {
        bannerView.updateMinus()
    }
    
}
