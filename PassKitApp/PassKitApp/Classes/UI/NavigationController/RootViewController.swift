//
//  RootViewController.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/10/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class RootViewController: UIViewController {

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let image = UIImage(named: BACK_BUTTON_IMAGE)
        
        let leftView = UIView(frame:  CGRectMake(0, 0, image.size.width * 1.2, 35))
        leftView.backgroundColor = UIColor.clearColor()
        
        
        let btn0 = UIButton(frame: CGRectMake(0,0,image.size.width, image.size.height))
        btn0.setImage(image, forState: UIControlState.Normal)
        btn0.addTarget(self, action: "backAction", forControlEvents: UIControlEvents.TouchUpInside)
        leftView.addSubview(btn0)
        

        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: leftView)
        
        
        let image1 = UIImage(named: "options_button")
        let image2 = UIImage(named: "ios7-help-icon")

        let rightView = UIView(frame:  CGRectMake(0, 0, image1.size.width * 1.2 + image2.size.width * 1.2, 30))
        rightView.backgroundColor = UIColor.clearColor()
        
        let btn1 = UIButton(frame: CGRectMake(0,0,image1.size.width, image1.size.height))
        btn1.setImage(image1, forState: UIControlState.Normal)
        btn1.addTarget(self, action: "optionsAction", forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(btn1)
        
        let btn2 = UIButton(frame: CGRectMake(image1.size.width * 1.2 + 10, 0,image2.size.width, image2.size.height))
        btn2.setImage(image2, forState: UIControlState.Normal)
        btn2.addTarget(self, action: "helpAction", forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(btn2)
        
        
        let rightBtn = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem = rightBtn;
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    func optionsAction()
    {
        var optionsController:OptionsViewController
        var mainStoryboard:UIStoryboard
        mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
        optionsController  =  mainStoryboard.instantiateViewControllerWithIdentifier("Options") as OptionsViewController
        self.navigationController?.pushViewController(optionsController, animated: true)
    }
    
    func helpAction()
    {
        let alert = UIAlertView()
        alert.title = "Comming soon..."
        alert.message = ""
        alert.addButtonWithTitle(BUTTON_TEXT_OK)
        alert.show()
//        let mainView:UIView = UIApplication.sharedApplication().windows.last as UIView
//        var view:UIView = UIView(frame: CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height))
//        view.backgroundColor = UIColor.blackColor()
//        view.alpha = 0.5
//        mainView.addSubview(view)
    }
    
    func hideLeftButton() {
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationItem.leftBarButtonItem = nil;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
