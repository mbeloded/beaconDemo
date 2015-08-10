//
//  AlertManager.swift
//  PassKitApp
//
//  Created by Migele Beloded on 10/8/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import Foundation

class AlertManager: NSObject{
    
    class var sharedInstance : AlertManager {
        
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : AlertManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = AlertManager()
        }
        return Static.instance!
    }
    
    // PRIVATE
    private override init() {
        super.init()
    }
    
    func showAlert(title: String, msg:String, delegate:UIAlertViewDelegate?, btn:String)
    {
        
//        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
//            
//            var alert : UIAlertController = UIAlertController(title: title, message: msg, preferredStyle: UIAlertControllerStyle.Alert)
//            alert.addAction(UIAlertAction(title: title, style:.Default, handler: nil))
//            vc.presentViewController(alert, animated: true, completion: nil)
//            
//        } else
//        {
        
            let alert = UIAlertView()
            alert.title = title
            alert.message = msg
            alert.delegate = delegate
            alert.addButtonWithTitle(btn)
            alert.show()
            
//        }
        
    }
    
    func showAlert(title: String, errorMsg:String, delegate:UIAlertViewDelegate?, cancelBtn:String, otherBtn:String, vc:UIViewController)
    {
        
        if let gotModernAlert: AnyClass = NSClassFromString("UIAlertController") {
            
            var alert : UIAlertController = UIAlertController(title: title, message: errorMsg, preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: title, style:.Default, handler: nil))
            vc.presentViewController(alert, animated: true, completion: nil)
            
        } else {
            
            let alert = UIAlertView()
            alert.title = title
            alert.message = errorMsg
            alert.delegate = delegate
            alert.addButtonWithTitle(cancelBtn)
            alert.addButtonWithTitle(otherBtn)
            alert.show()
            
        }

    }
    
}