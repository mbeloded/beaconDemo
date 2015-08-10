//
//  AppDelegate.m
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import "AppDelegate.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import <CoreLocation/CoreLocation.h>
#import "TAlertManager.h"
#import "Constants.h"
#import "BeaconItem.h"


@interface AppDelegate () <CLLocationManagerDelegate, CBCentralManagerDelegate>
            
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (strong, nonatomic) CBCentralManager *bluetoothManager;
@property (strong, nonatomic) CLBeaconRegion *beaconRegion;
@property (strong, nonatomic) NSMutableArray *items;
@end

@implementation AppDelegate
            
static BOOL isBeaconAchieved;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    UILocalNotification *notification = [launchOptions objectForKey:UIApplicationLaunchOptionsLocalNotificationKey];
    
    NSLog(@"missed notification: %@", notification);
    
    if (notification)
    {
//        [alertManager showAlert:[[NSString alloc] initWithFormat:@" You have missed notifications: /t%@", notification.description]];
    }
    else
    {
        isBeaconAchieved = NO;
    }
    
    [self initLocationManager];
    
    [self detectBluetooth];
    
    return YES;
}

- (void)loadItems {
    NSArray *storedItems = [[NSUserDefaults standardUserDefaults] arrayForKey:STORED_ITEMS_KEY];
    self.items = [NSMutableArray array];
    
    if (storedItems) {
        for (NSData *itemData in storedItems) {
            BeaconItem *item = [NSKeyedUnarchiver unarchiveObjectWithData:itemData];
            [self.items addObject:item];
            [self startMonitoringItem:item];
        }
    }
    else
    {
        BeaconItem* itemTmp = [[BeaconItem alloc] init];
        itemTmp.uuid = [[NSUUID alloc] initWithUUIDString:UUID];
        itemTmp.majorValue = BEACON_MAJOR;
        itemTmp.minorValue = BEACON_MINOR;
        itemTmp.name = BEACON_ID;
        
        [self.items addObject:itemTmp];
        [self startMonitoringItem:itemTmp];
    }
}

- (void)persistItems {
    NSMutableArray *itemsDataArray = [NSMutableArray array];
    for (BeaconItem *item in self.items) {
        NSData *itemData = [NSKeyedArchiver archivedDataWithRootObject:item];
        [itemsDataArray addObject:itemData];
    }
    [[NSUserDefaults standardUserDefaults] setObject:itemsDataArray forKey:STORED_ITEMS_KEY];
}

- (CLBeaconRegion *)beaconRegionWithItem:(BeaconItem *)item {
    CLBeaconRegion *beaconRegion = [[CLBeaconRegion alloc] initWithProximityUUID:item.uuid
                                                                           major:item.majorValue
                                                                           minor:item.minorValue
                                                                      identifier:item.name];
    return beaconRegion;
}

- (void) startMonitoringItem:(BeaconItem *) item
{
    
    self.beaconRegion = [self beaconRegionWithItem:item];
    
    [self.locationManager startMonitoringForRegion:self.beaconRegion];
    [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
    
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
}

- (void) stopMonitoringItem
{
    if(!self.beaconRegion)
        return;
    
    [self.locationManager stopMonitoringForRegion:self.beaconRegion];
    [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark Location manager
- (void) initLocationManager
{
    if (nil == self.locationManager)
        self.locationManager = [[CLLocationManager alloc] init];
    
    self.locationManager.delegate = self;
    //    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    //    // Set a movement threshold for new events.
    //    self.locationManager.distanceFilter = 0.3; // meters
    //
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didEnterRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        [self showNotification:HI];
    }
}

- (void)locationManager:(CLLocationManager *)manager didExitRegion:(CLRegion *)region {
    if ([region isKindOfClass:[CLBeaconRegion class]]) {
        if(isBeaconAchieved) {
            isBeaconAchieved = NO;
            [self showNotification:GOOD_BYE];
        }
    }
}

- (void)locationManager:(CLLocationManager *)manager monitoringDidFailForRegion:(CLRegion *)region withError:(NSError *)error {
    NSLog(@"Failed monitoring region: %@", error);
    [alertManager showAlert:@"Failed monitoring region" errorMsg:error.description];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    NSLog(@"Location manager failed: %@", error);
    [alertManager showAlert:@"Location manager failed: " errorMsg:error.description];
}

- (void)locationManager:(CLLocationManager *)manager
        didRangeBeacons:(NSArray *)beacons
               inRegion:(CLBeaconRegion *)region
{
    
    for (CLBeacon *beacon in beacons) {
        for (BeaconItem *item in self.items) {
            if ([item isEqualToCLBeacon:beacon]) {
                item.lastSeenBeacon = beacon;
                [self showBeaconInfo:beacon];
            }
        }
        
    }
    
}

- (void)locationManager:(CLLocationManager *)manager didDetermineState:(CLRegionState)state forRegion:(CLRegion *)region
{
    // Scan our registered notifications to see if this state change
    // has a user message associated with it
    NSString * stateStr = @"";
    
    switch (state) {
        case CLRegionStateUnknown:
        {
            [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
            stateStr = @"unknown";
            break;
        }
        case CLRegionStateInside:
        {
            [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
            stateStr = @"You are inside of beacon range";
            break;
        }
        case CLRegionStateOutside:
        {
            [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
            stateStr = @"You are outside of beacon range";
            if(isBeaconAchieved) {
                isBeaconAchieved = NO;
                [self.startViewController hideAll];
            }
            break;
            
        default:
            break;
        }
    }
    [self.startViewController.rangeStatus setText:stateStr];
    
}

#pragma mark notifications/navigation

- (void) showNotification:(int) type
{
    NSString * notificationMsg = nil;
    
    UILocalNotification *notification = [[UILocalNotification alloc] init];
    
    notification.alertAction = @"";
    notification.soundName = UILocalNotificationDefaultSoundName;
    notification.alertLaunchImage = ALERT_NOTIFICATION;
    switch(type){
        case HI:
            notificationMsg = @"Hi ;)";
            notification.alertAction = @"welcome";
            
            break;
        case GOOD_BYE:
            notificationMsg = @"Good bye";
            break;
        case CHECK_OUT_PRODUCT:
            notificationMsg = [[NSString alloc] initWithFormat:@"Check out prod id: %@", self.item.lastSeenBeacon.minor];
            notification.alertAction = @"see details";
            break;
    }
    
    notification.alertBody = notificationMsg;
    
    NSDictionary *infoDict = [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithInt:type], NOTIF_KEY, nil];
    notification.userInfo = infoDict;
    
    [[UIApplication sharedApplication] presentLocalNotificationNow:notification];
}

- (void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {

    NSLog(@"AppDelegate didReceiveLocalNotification %@", notification.userInfo[NOTIF_KEY]);
    
    int typeValue = [notification.userInfo[NOTIF_KEY] intValue];
    switch (typeValue) {
        case HI:
            [self.startViewController hideAll];
            break;
        case GOOD_BYE:
            [self.startViewController showGoodBye];
            break;
        default:
            [self goToProdPage:self.item.minorValue];
            break;
    }
    
}

- (void) goToProdPage:(int) type
{
    UINavigationController *navigationController = (UINavigationController*) self.window.rootViewController;
    [[[navigationController viewControllers] objectAtIndex:0] performSegueWithIdentifier:@"goToProduct" sender:self];
}

/*
 each minor Value should be storeId in moll, or in array of one brand-name stores
 */

- (void) showBeaconInfo: (CLBeacon *) beacon {
    
    NSArray* proximityToString = @[@"Unknown", @"Immediate", @"Near", @"Far"];
    
    NSString * beaconProximityStr = [[NSString alloc] initWithFormat:@"%@", proximityToString[beacon.proximity]];
    
    BeaconItem* itemTmp = [[BeaconItem alloc] init];
    itemTmp.uuid = beacon.proximityUUID;
    itemTmp.name = beaconProximityStr;
    itemTmp.minorValue = [beacon.minor integerValue];
    itemTmp.majorValue = [beacon.major integerValue];
    itemTmp.lastSeenBeacon = beacon;
    
    self.item = itemTmp;

//    NSLog(@"\tProximity: %@ Accuracy: %f Rssi:%ld", proximityToString[beacon.proximity], beacon.accuracy, (long)beacon.rssi);

    switch (beacon.proximity) {
        case CLProximityUnknown:
            if(isBeaconAchieved) {
                isBeaconAchieved = NO;
                [self showNotification:GOOD_BYE];
            }
            break;
        case CLProximityImmediate:
            if (!isBeaconAchieved) {
                //TODO need to handle situation if product is new - then update prodVC
                if(![((UINavigationController*)self.window.rootViewController).visibleViewController isEqual:self.prodViewController]) {
                    isBeaconAchieved = YES;
                    [self showNotification:CHECK_OUT_PRODUCT];
                }
            }
            else
            {
                [self.startViewController showProdBtn];
            }
            break;
        case CLProximityNear:
            if (!isBeaconAchieved) {
                //TODO need to handle situation if product is new - then update prodVC
                if(![((UINavigationController*)self.window.rootViewController).visibleViewController isEqual:self.prodViewController]) {
                    isBeaconAchieved = YES;
                    [self showNotification:CHECK_OUT_PRODUCT];
                }
            }
            else
            {
                [self.startViewController showProdBtn];
            }
            break;
        case CLProximityFar:
            if(isBeaconAchieved) {
                isBeaconAchieved = NO;
                [self.startViewController hideProdBtn];
            }
            break;
    }

    NSString * debugStr = [NSString stringWithFormat:@"%@ is %@", BEACON_ID, beaconProximityStr];
    //[NSString stringWithFormat:@"%@ | %hu | %f is %@ | ach_status: %@", BEACON_ID, itemTmp.minorValue, itemTmp.lastSeenBeacon.accuracy, beaconProximityStr, isBeaconAchieved ? @"Yes" : @"No"];
    
    [self.startViewController.infoLabel setText:debugStr];
}

#pragma mark Bluetooth manager
- (void)detectBluetooth
{
    if(!self.bluetoothManager)
    {
        // Put on main queue so we can call UIAlertView from delegate callbacks.
        self.bluetoothManager = [[CBCentralManager alloc] initWithDelegate:self queue:dispatch_get_main_queue()];
    }
    [self centralManagerDidUpdateState:self.bluetoothManager]; // Show initial state
}

- (void)centralManagerDidUpdateState:(CBCentralManager *)central
{
    NSString *stateString = nil;
    BOOL statusIsOk = NO;
    switch(self.bluetoothManager.state)
    {
        case CBCentralManagerStateResetting:
            stateString = @"The connection with the system service was momentarily lost, update imminent.";
            break;
        case CBCentralManagerStateUnsupported:
            stateString = @"The platform doesn't support Bluetooth Low Energy.";
            break;
        case CBCentralManagerStateUnauthorized:
            stateString = @"The app is not authorized to use Bluetooth Low Energy.";
            break;
        case CBCentralManagerStatePoweredOff:
            stateString = @"Bluetooth is currently powered off.";
            break;
        case CBCentralManagerStatePoweredOn:
            stateString = @"Bluetooth is currently powered on and available to use.";
            statusIsOk = YES;
            break;
        default:
            stateString = @"unknown";
            statusIsOk = NO;
//            stateString = @"State unknown, update imminent.";
            break;
    }
    NSLog(@"self.bluetoothManager.state = %ld",self.bluetoothManager.state);
    if(statusIsOk){
        [self loadItems];
        [self.startViewController hideAll];
    }
    else if (![stateString isEqualToString:@"unknown"])
    {
        isBeaconAchieved = NO;
        [self stopMonitoringItem];
        [alertManager showAlert:@"Bluetooth state" errorMsg:stateString];
        [self.startViewController showBtOff];
    }
    
}

@end
