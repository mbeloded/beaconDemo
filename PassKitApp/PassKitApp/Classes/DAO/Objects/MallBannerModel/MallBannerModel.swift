//
//  MallBannerModel.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/8/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit
import CoreData

class MallBannerModel: NSManagedObject {
    @NSManaged var id:String!
    @NSManaged var mall_id:String!
    @NSManaged var banner_id:String!
    @NSManaged var createdAt:NSDate
    @NSManaged var updatedAt:NSDate

}
