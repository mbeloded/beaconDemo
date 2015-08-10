//
//  BeaconModel.swift
//  PassKitApp
//
//  Created by Alexandr Chernyy on 10/3/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import UIKit

class BeaconModel: NSObject {
    var beacon_id:Int = 0
    var beacon_uuid:String!
    var beacon_minor:Int = 0
    var beacon_major:Int = 0
    var beacon_identifier:String!
    var beacon_distance:Int = 0
    var store_id:Int = 0
    var floor_id:Int = 0
}
