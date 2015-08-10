//
//  BeaconManager.m
//  ibeacon
//
//  Created by Migele Beloded on 9/26/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import "BeaconManager.h"

NSString * const DidEnterRegionNotification = @"DidEnterRegionNotification";
NSString * const DidExitRegionNotification = @"DidExitRegionNotification";
NSString * const RangingNotification = @"RangingNotification";

@interface BeaconManager()

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation BeaconManager

+ (instancetype)sharedManager {
	static BeaconManager *_sharedManager;
	
	if (!_sharedManager) {
		_sharedManager = [[[self class] alloc] init];
		NSBlockOperation *op = [NSBlockOperation blockOperationWithBlock:^{
			CLLocationManager *locationManager = [[CLLocationManager alloc] init];
			locationManager.delegate = _sharedManager;
			//These two settings sacrifice battery life for a smoother demo experience.
			[locationManager disallowDeferredLocationUpdates];
			locationManager.pausesLocationUpdatesAutomatically = NO;
			
			_sharedManager->_locationManager = locationManager;
		}];
		[[NSOperationQueue mainQueue] addOperation:op];
		[op waitUntilFinished];
		
	}
	return _sharedManager;
}

- (void)beginRegionMonitoring
{
//	NSArray *regionKeys;
//	@synchronized(self) {
//		regionKeys = [self.URLStore allKeys];
//	}
//	for (NSString *key in regionKeys) {
//		NSArray *regionTriplet = [key componentsSeparatedByString:@":"];
//		NSUUID *proximityUUID = [[NSUUID alloc] initWithUUIDString:regionTriplet[0]];
//		CLBeaconMajorValue major = [(NSString *)regionTriplet[1] integerValue];
//		CLBeaconMinorValue minor = [(NSString *)regionTriplet[2] integerValue];
//		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//			CLBeaconRegion *region = [[CLBeaconRegion alloc] initWithProximityUUID:proximityUUID major:major minor:minor identifier:key];
//			[self.locationManager startMonitoringForRegion:region];
//		}];
//	}
	
}

#pragma mark - CLLocationManager Delegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region
{
	NSLog(@"Entered Region");
	UIApplicationState state = [[UIApplication sharedApplication] applicationState];
	switch (state) {
		case UIApplicationStateInactive:
		case UIApplicationStateActive:
			[[NSNotificationCenter defaultCenter] postNotificationName:DidEnterRegionNotification
																object:self
															  userInfo:@{@"region": region}];
            
			break;
		case UIApplicationStateBackground: {
			UILocalNotification *notification = [[UILocalNotification alloc] init];
//			notification.alertBody = self.entryText;
			[[UIApplication sharedApplication] presentLocalNotificationNow:notification];
		}
		default:
			break;
	}
    
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region
{
	NSLog(@"Exited Region");
	UIApplicationState state = [[UIApplication sharedApplication] applicationState];
	switch (state) {
		case UIApplicationStateInactive:
		case UIApplicationStateActive:
			[[NSNotificationCenter defaultCenter] postNotificationName:DidExitRegionNotification
																object:self
															  userInfo:@{@"region": region}];
            
			break;
		case UIApplicationStateBackground:{
			UILocalNotification *notification = [[UILocalNotification alloc] init];
//			notification.alertBody = self.exitText;
			[[UIApplication sharedApplication] presentLocalNotificationNow:notification];
		}
		default:
			break;
	}
	[manager startMonitoringForRegion:region];
}

- (void)locationManager:(CLLocationManager *)manager didRangeBeacons:(NSArray *)beacons inRegion:(CLBeaconRegion *)region
{
	NSLog(@"Ranged %lu Beacons", (unsigned long)[beacons count]);
	if ([beacons count] > 0) {
		//Doesn't deal gracefully with multiple beacons in range
		CLBeacon *closestBeacon = beacons[0];
		NSNumber *index;
		switch (closestBeacon.proximity) {
			case CLProximityFar:
				index = @0;
				break;
			case CLProximityNear:
				NSLog(@"Near");
				index = @1;
				break;
			case CLProximityImmediate:
				NSLog(@"Immediate");
				index = @2;
				break;
			case CLProximityUnknown:
				NSLog(@"Unknown");
				index = @3;
				break;
		}
		[[NSNotificationCenter defaultCenter] postNotificationName:RangingNotification object:self userInfo:@{@"index": index, @"beacon": closestBeacon}];
	}
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region{
	CLBeaconRegion *beaconRegion = (CLBeaconRegion *)region;
	switch (state) {
		case CLRegionStateInside:
			NSLog(@"Determined Inside State for Beacon %@", beaconRegion.identifier);
			if ([CLLocationManager isRangingAvailable]) {
				[self.locationManager startRangingBeaconsInRegion:beaconRegion];
			}
			break;
		case CLRegionStateOutside:
			NSLog(@"Determined Outside State for Beacon %@", beaconRegion.identifier);
			if ([CLLocationManager isRangingAvailable]) {
				[self.locationManager stopRangingBeaconsInRegion:beaconRegion];
			}
			break;
		case CLRegionStateUnknown:
			NSLog(@"Determined Unknown State for Beacon %@", beaconRegion.identifier);
			break;
	}
}

@end
