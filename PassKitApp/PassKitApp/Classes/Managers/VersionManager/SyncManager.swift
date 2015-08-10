//
//  SyncManager.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/6/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class SyncManager: NSObject, ParseManagerDelegate {
 
    class var sharedManager : SyncManager {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : SyncManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = SyncManager()
        }
        return Static.instance!
    }

    var action:ActionType = ActionType.NO_ACTION
    
    func start()
    {
        ParseManager.sharedInstance.delegate = self
        action = ActionType.VERSION
        ParseManager.sharedInstance.getBaseVersionFromServer()
    }
    
    func checkVersion()
    {
        if(self.serverHaveNewVersion())
        {
            var items:Array<AnyObject> = []
            items.append(ParseManager.sharedInstance.getBaseVersionFromServerObject())
            CoreDataManager.sharedManager.saveData(saveArray: items, requestType: RequestType.VERSION)
            action = ActionType.CATEGORY
            ParseManager.sharedInstance.getCategoryFromServer()
            
            //have new version
        } else {
            action = ActionType.SYNC_COMPLETE
            NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_SYNC_COMPLETE, object: nil)
            // do not have new version
        }
    
    }
    
    func serverHaveNewVersion()->Bool
    {
        var result = false
        var serverVersion: AnyObject! = (ParseManager.sharedInstance.getBaseVersionFromServerObject() as PFObject)["version"]
        
        
        println("server version: \(serverVersion) local version: \(self.loadVersionFromLocal())")
        if(serverVersion as NSString != self.loadVersionFromLocal())
        {
            result = true
        }
        return result
    }
    
    func loadVersionFromLocal()->String
    {
        var version:String = "-1"
        var data:Array = CoreDataManager.sharedManager.loadData(RequestType.VERSION)
        for object in data {
            version = (object as Version).version
        }
        return version
    }

    func parseRequestComplete()
    {
        switch(action) {
        case ActionType.VERSION:
            self.checkVersion()
            break;
        case ActionType.CATEGORY:
            self.syncCategory()
            break;
        case ActionType.MALL:
            self.syncMall()
            break;
        case ActionType.BANNER:
            self.syncBanner()
            break;
        case ActionType.MALL_BANNER:
            self.syncMallBanner()
            break;
        case ActionType.STORE:
            self.syncStore()
            break;
        case ActionType.SYNC_COMPLETE:
            NSNotificationCenter.defaultCenter().postNotificationName(NOTIFICATION_SYNC_COMPLETE, object: nil)
            break;
        default:
            break;
        }
    }
    
    func parseRequestError(error:String)
    {
        let alert = UIAlertView()
        alert.title = error
        alert.message = ""
        alert.addButtonWithTitle(BUTTON_TEXT_OK)
        alert.show()
    }
 
    func syncCategory()
    {
        CoreDataManager.sharedManager.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.CATEGORY)
        action = ActionType.MALL
        ParseManager.sharedInstance.getMallFromServer()
    }

    func syncMall()
    {
        CoreDataManager.sharedManager.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.MALL)
        action = ActionType.BANNER
        ParseManager.sharedInstance.getBannerFromServer()
    }

    func syncBanner()
    {
        CoreDataManager.sharedManager.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.BANNER)
        action = ActionType.MALL_BANNER
        ParseManager.sharedInstance.getMallBannerFromServer()
    }

    func syncMallBanner()
    {
        CoreDataManager.sharedManager.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.MALL_BANNER)
        action = ActionType.STORE
        ParseManager.sharedInstance.getStoreFromServer()
    }

    func syncStore()
    {
        CoreDataManager.sharedManager.saveData(saveArray: ParseManager.sharedInstance.serverObjects, requestType: RequestType.STORE)
        action = ActionType.SYNC_COMPLETE
        self.parseRequestComplete()
    }
}
