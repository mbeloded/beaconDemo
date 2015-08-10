//
//  Version.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/6/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit
import CoreData

class Version: NSManagedObject {

    @NSManaged var version: String
    @NSManaged var createdAt:NSDate
    @NSManaged var updatedAt:NSDate

}
