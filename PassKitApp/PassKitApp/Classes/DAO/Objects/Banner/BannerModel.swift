//
//  BannerModel.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit
import CoreData

class BannerModel: NSManagedObject {
    @NSManaged var id:String!
    @NSManaged var image:String!
    @NSManaged var type_id:String!
    @NSManaged var createdAt:NSDate
    @NSManaged var updatedAt:NSDate
}
