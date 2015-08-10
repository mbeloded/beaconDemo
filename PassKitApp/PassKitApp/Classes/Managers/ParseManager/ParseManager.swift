//
//  ParseManager.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/6/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit
import CoreData

protocol ParseManagerDelegate
{
    func parseRequestComplete()
    func parseRequestError(error:String)
}

class ParseManager: NSObject {
    class var sharedInstance : ParseManager {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : ParseManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = ParseManager()
        }
        return Static.instance!
    }
    
    var delegate:ParseManagerDelegate?
    var serverVersionObject:PFObject!
    
    var serverObjects:Array<AnyObject> = []
    
    func start()
    {
        Parse.setApplicationId(PARSE_APP_KEY, clientKey: PARSE_CLIENT_KEY)
    }

    func getBaseVersionFromServerObject()->PFObject
    {
        return serverVersionObject
    }
    
    func getBaseVersionFromServer()
    {
        var query = PFQuery(className: "ServerVersion")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) version.")
                // Do something with the found objects
                for object in objects {
                    
                    self.serverVersionObject = object as PFObject
                    
                    NSLog("%@", object.objectId)
                    var serverVerion = object["version"] as String
                    println("version: \(serverVerion)")
                    self.delegate?.parseRequestComplete()
                }
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }
    
    //Need optimize this code!!!!!
    
    func getCategoryFromServer()
    {
        var query = PFQuery(className: "CategoryModel")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) category.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getMallFromServer()
    {
        var query = PFQuery(className: "MallModel")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) mall.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getBannerFromServer()
    {
        var query = PFQuery(className: "BannerModel")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) banner.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getMallBannerFromServer()
    {
        var query = PFQuery(className: "MallBannerModel")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) mall_banners.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    func getStoreFromServer()
    {
        var query = PFQuery(className: "StoreModel")
        query.findObjectsInBackgroundWithBlock {
            (objects: [AnyObject]!, error: NSError!) -> Void in
            if error == nil {
                // The find succeeded.
                NSLog("Successfully retrieved \(objects.count) stores.")
                // Do something with the found objects
                self.serverObjects.removeAll(keepCapacity: false)
                
                for object in objects {
                    self.serverObjects.append(object as PFObject)
                }
                self.delegate?.parseRequestComplete()
            } else {
                // Log details of the failure
                self.delegate?.parseRequestError(error.localizedDescription)
                NSLog("Error: %@ %@", error, error.userInfo!)
            }
        }
    }

    //All this
}
