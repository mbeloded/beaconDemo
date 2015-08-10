//
//  BeaconItem.h
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreLocation;

@interface BeaconItem : NSObject <NSCoding>

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSUUID *uuid;
@property (assign, nonatomic) CLBeaconMajorValue majorValue;
@property (assign, nonatomic) CLBeaconMajorValue minorValue;
@property (strong, nonatomic) CLBeacon *lastSeenBeacon;

- (BOOL)isEqualToCLBeacon:(CLBeacon *)beacon;

@end
