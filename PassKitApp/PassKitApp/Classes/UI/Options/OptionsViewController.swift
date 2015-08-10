//
//  OptionsViewController.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/10/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class OptionsViewController: UIViewController {

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
        
        
        let image2 = UIImage(named: "ios7-help-icon")
        
        let rightView = UIView(frame:  CGRectMake(0, 0, image2.size.width * 1.2, 30))
        rightView.backgroundColor = UIColor.clearColor()
        
        
        let btn2 = UIButton(frame: CGRectMake(0, 0,image2.size.width, image2.size.height))
        btn2.setImage(image2, forState: UIControlState.Normal)
        btn2.addTarget(self, action: "helpAction", forControlEvents: UIControlEvents.TouchUpInside)
        rightView.addSubview(btn2)
        
        
        let rightBtn = UIBarButtonItem(customView: rightView)
        self.navigationItem.rightBarButtonItem = rightBtn;

    }

    func helpAction()
    {
        let alert = UIAlertView()
        alert.title = "Comming soon..."
        alert.message = ""
        alert.addButtonWithTitle(BUTTON_TEXT_OK)
        alert.show()
    }

    
    func backAction() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
