//
//  CategoryModel.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit
import CoreData

class CategoryModel: NSManagedObject {
    @NSManaged var id:String
    @NSManaged var name:String?
    @NSManaged var icon:String?
    @NSManaged var createdAt:NSDate
    @NSManaged var updatedAt:NSDate
}
