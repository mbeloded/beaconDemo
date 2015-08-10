//
//  CoreDataManager.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/6/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSManagedObject {
    class var sharedManager : CoreDataManager {
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : CoreDataManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = CoreDataManager()
        }
        return Static.instance!
    }

    //var appDelegate:AppDelegate = UIApplication.sharedApplication().delegate as AppDelegate
    var contxt:NSManagedObjectContext! = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    
    init() {
        self.contxt = (UIApplication.sharedApplication().delegate as AppDelegate).managedObjectContext!
    }
    
    func start()
    {
//        self.appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
//        self.contxt = appDelegate.managedObjectContext
    }
    
    func initNewObject(requestType:RequestType)->AnyObject
    {
        var object:AnyObject!
        switch(requestType)
            {
        case RequestType.VERSION:
                let en = NSEntityDescription.entityForName("Version", inManagedObjectContext: self.contxt)
                object = en
            break;
            
        default:
            break;
        }
        return object
    }
    
    
    func saveData(saveArray savedArray:Array<AnyObject>, requestType:RequestType)
    {
        switch(requestType)
            {
            case .VERSION:
                self.removeData(.VERSION)
                    for object in savedArray
                    {
                        let en = NSEntityDescription.entityForName("Version", inManagedObjectContext: self.contxt)
                        var newItem = Version(entity: en!, insertIntoManagedObjectContext: contxt)
                        newItem.version = (object as PFObject)["version"] as String
                        newItem.createdAt = (object as PFObject).createdAt
                        newItem.updatedAt = (object as PFObject).updatedAt
                    }
            break;
        case .CATEGORY:
            self.removeData(.CATEGORY)
            for object in savedArray
            {
                let en = NSEntityDescription.entityForName("CategoryModel", inManagedObjectContext: self.contxt)
                var newItem = CategoryModel(entity: en!, insertIntoManagedObjectContext: contxt)
                var object1:PFObject = (object as PFObject)
                
                var icon:PFFile = (object as PFObject)["icon"] as PFFile
                
                
                var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(icon.name)");
                var imageData:NSData = icon.getData()
                imageData.writeToFile(pngPath, atomically: true)
                
                newItem.id = (object as PFObject).objectId
                newItem.name = (object as PFObject)["name"] as? String
                newItem.icon = ((object as PFObject)["icon"] as? PFFile)?.url
                newItem.createdAt = (object as PFObject).createdAt
                newItem.updatedAt = (object as PFObject).updatedAt
            }
            break;
        case .MALL:
            self.removeData(.MALL)
            for object in savedArray
            {
                let en = NSEntityDescription.entityForName("MallModel", inManagedObjectContext: self.contxt)
                var newItem = MallModel(entity: en!, insertIntoManagedObjectContext: contxt)
                var object1:PFObject = (object as PFObject)
                
                newItem.id = (object as PFObject).objectId
                newItem.name = (object as PFObject)["name"] as? String
                newItem.beacon_id = (object as PFObject)["beacon_id"] as? String
                newItem.information = (object as PFObject)["information"] as? String
                newItem.location = (object as PFObject)["location"] as? String
                newItem.createdAt = (object as PFObject).createdAt
                newItem.updatedAt = (object as PFObject).updatedAt
            }
            break;
        case .BANNER:
            self.removeData(.BANNER)
            for object in savedArray
            {
                let en = NSEntityDescription.entityForName("BannerModel", inManagedObjectContext: self.contxt)
                var newItem = BannerModel(entity: en!, insertIntoManagedObjectContext: contxt)
                var object1:PFObject = (object as PFObject)
                
                var icon:PFFile = (object as PFObject)["image"] as PFFile
                
                
                var pngPath:NSString   = NSHomeDirectory().stringByAppendingPathComponent("Documents/\(icon.name)");
                var imageData:NSData = icon.getData()
                imageData.writeToFile(pngPath, atomically: true)
                
                newItem.id = (object as PFObject).objectId
                newItem.type_id = (object as PFObject)["type_id"] as? String
                newItem.image = ((object as PFObject)["image"] as? PFFile)?.url
                newItem.createdAt = (object as PFObject).createdAt
                newItem.updatedAt = (object as PFObject).updatedAt
            }
            break;
        case .MALL_BANNER:
            self.removeData(.MALL_BANNER)
            for object in savedArray
            {
                let en = NSEntityDescription.entityForName("MallBannerModel", inManagedObjectContext: self.contxt)
                var newItem = MallBannerModel(entity: en!, insertIntoManagedObjectContext: contxt)
                newItem.id = (object as PFObject).objectId
                newItem.mall_id = (object as PFObject)["mall_id"] as? String
                newItem.banner_id = (object as PFObject)["banner_id"] as? String
                newItem.createdAt = (object as PFObject).createdAt
                newItem.updatedAt = (object as PFObject).updatedAt
            }
            break;
        case .STORE:
            self.removeData(.STORE)
            for object in savedArray
            {
                let en = NSEntityDescription.entityForName("StoreModel", inManagedObjectContext: self.contxt)
                var newItem = StoreModel(entity: en!, insertIntoManagedObjectContext: contxt)
                newItem.id = (object as PFObject).objectId
                newItem.name = (object as PFObject)["name"] as? String
                newItem.details = (object as PFObject)["details"] as? String
                newItem.banner_id = (object as PFObject)["banner_id"] as? String
                newItem.beacon_id = (object as PFObject)["beacon_id"] as? String
                newItem.location = (object as PFObject)["location"] as? String
                newItem.category_id = (object as PFObject)["category_id"] as? String
                newItem.createdAt = (object as PFObject).createdAt
                newItem.updatedAt = (object as PFObject).updatedAt
            }
            break;
            
        default:
            break;
        }
        contxt.save(nil)
    }
    
    func loadData(requestType:RequestType)->Array<AnyObject>
    {
        var data:Array<AnyObject>? = []
        var freq:NSFetchRequest!
        switch(requestType)
            {
            case RequestType.VERSION:
                freq = NSFetchRequest(entityName: "Version")
            break;
        case .CATEGORY:
            freq = NSFetchRequest(entityName: "CategoryModel")
            break;
        case .MALL:
            freq = NSFetchRequest(entityName: "MallModel")
            break;
        case .BANNER:
            freq = NSFetchRequest(entityName: "BannerModel")
            break;
        case .MALL_BANNER:
            freq = NSFetchRequest(entityName: "MallBannerModel")
            break;
        case .STORE:
            freq = NSFetchRequest(entityName: "StoreModel")
            break;
            
        default:
            break;
        }
        if self.contxt != nil {
            data = self.contxt.executeFetchRequest(freq, error: nil)!
        }
        return data!
    }

    func loadData(requestType:RequestType, key:String)->Array<AnyObject>
    {
        var data:Array<AnyObject>? = []
        var freq:NSFetchRequest!
        switch(requestType)
            {
        case RequestType.VERSION:
            freq = NSFetchRequest(entityName: "Version")
            break;
        case .CATEGORY:
            freq = NSFetchRequest(entityName: "CategoryModel")
            break;
        case .MALL:
            freq = NSFetchRequest(entityName: "MallModel")
            break;
        case .BANNER:
            freq = NSFetchRequest(entityName: "BannerModel")
            
            let predicate = NSPredicate(format: "id == %@", key)
            println(predicate)
            freq.predicate = predicate
            break;
        case .MALL_BANNER:
            freq = NSFetchRequest(entityName: "MallBannerModel")
            let predicate = NSPredicate(format: "mall_id == %@", key)
            println(predicate)
            freq.predicate = predicate
            break;
        case .STORE:
            freq = NSFetchRequest(entityName: "StoreModel")
            let predicate = NSPredicate(format: "category_id == %@", key)
            println(predicate)
            freq.predicate = predicate
            break;
            
        default:
            break;
        }
        if self.contxt != nil {
            data = self.contxt.executeFetchRequest(freq, error: nil)!
        }
        return data!
    }

    func removeData(requestType:RequestType)
    {
        var freq:NSFetchRequest!
        switch(requestType)
            {
            case RequestType.VERSION:
                freq = NSFetchRequest(entityName: "Version")
                var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
                if(results.count > 0)
                {
                    for object in results {
                        self.contxt.deleteObject(object as NSManagedObject)
                        self.contxt.save(nil)
                    }
                }
            break;
        case .CATEGORY:
            freq = NSFetchRequest(entityName: "CategoryModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.deleteObject(object as NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .MALL:
            freq = NSFetchRequest(entityName: "MallModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.deleteObject(object as NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .BANNER:
            freq = NSFetchRequest(entityName: "BannerModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.deleteObject(object as NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .MALL_BANNER:
            freq = NSFetchRequest(entityName: "MallBannerModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.deleteObject(object as NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
        case .STORE:
            freq = NSFetchRequest(entityName: "StoreModel")
            var results:NSArray = self.contxt.executeFetchRequest(freq, error: nil)!
            if(results.count > 0)
            {
                for object in results {
                    self.contxt.deleteObject(object as NSManagedObject)
                    self.contxt.save(nil)
                }
            }
            break;
            
        default:
            break;
        }
    }
    
}
