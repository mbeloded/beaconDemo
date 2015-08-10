//
//  BeaconManager.h
//  ibeacon
//
//  Created by Migele Beloded on 9/26/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <UIKit/UIKit.h>

/*!
 Notification constants. The TCSBleuBeaconManager registeres as the delegate
 to CoreLocation, and turns delegate callbacks into notifications.
 
 TCSBleuRangingNotification is called while the device is in the beacon region
 and changes proximity.
 */
extern NSString * const DidEnterRegionNotification;
extern NSString * const DidExitRegionNotification;
extern NSString * const RangingNotification;

@interface BeaconManager : NSObject <CLLocationManagerDelegate>

+ (instancetype) sharedManager;

/*
 Begins monitoring all the regions added with the addMappingsWithDictionary:
 There is currently no way to stop monitoring regions. Without going directly
 to CoreLocation.
 */
- (void)beginRegionMonitoring;

@end
