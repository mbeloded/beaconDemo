//
//  BeaconManager.swift
//  PassKitApp
//
//  Created by Migele Beloded on 10/6/14.
//  Copyright (c) 2014 Alexandr Chernyy. All rights reserved.
//

import Foundation
protocol BeaconManagerDelegate
{

}

class BeaconManager: NSObject, BluetoothManagerDelegate, CLLocationManagerDelegate {
    
    private let proximityUUID = NSUUID(UUIDString:"19D5F76A-FD04-5AA3-B16E-E93277163AF6")
    private let locationManager     : CLLocationManager!
    private var beaconRegion        : CLBeaconRegion!
    private var btStatus            : String!
    private var delegate            : BeaconManagerDelegate?
    private var isBeaconAchieved    : Bool
    
    class var sharedInstance : BeaconManager {
        
    struct Static {
        static var onceToken : dispatch_once_t = 0
        static var instance : BeaconManager? = nil
        }
        dispatch_once(&Static.onceToken) {
            Static.instance = BeaconManager()
        }
        return Static.instance!
    }
    
    // PRIVATE
    override init() {
        
        self.isBeaconAchieved = false;
        
        super.init()
        
        locationManager = CLLocationManager()
        
        setup()
        
    }
    
    func setup()
    {
        beaconRegion = CLBeaconRegion(proximityUUID:proximityUUID,identifier:"GemTot USB")
        
        BluetoothManager.sharedInstance
        BluetoothManager.sharedInstance.delegate = self
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.startUpdatingLocation()
    }
    
//LocationManager Delegate
    func locationManager(manager: CLLocationManager!, didStartMonitoringForRegion region: CLRegion!) {
        manager.requestStateForRegion(region)
        println("Scanning...")
    }
    
    func locationManager(manager:CLLocationManager, didUpdateLocations locations:[AnyObject]) {
        println("locations = \(locations)")
    }
    
    func locationManager(manager: CLLocationManager!, didEnterRegion region:CLRegion!) {
        if region.isKindOfClass(CLBeaconRegion)
        {
            println("HI")
            AlertManager.sharedInstance.showAlert("iBeacon", msg: "HI", delegate: nil, btn: "Ok")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didExitRegion region:CLRegion!) {
        if region.isKindOfClass(CLBeaconRegion)
        {
            if self.isBeaconAchieved {
                self.isBeaconAchieved = false
                println("GOOD_BYE")
                AlertManager.sharedInstance.showAlert("iBeacon", msg: "GOOD_BYE", delegate: nil, btn: "Ok")
            }
        }
    }
    
    func locationManager(manager: CLLocationManager!, monitoringDidFailForRegion region: CLRegion!, withError error: NSError!) {
//        NSLog(@"Failed monitoring region: %@", error);
//        [alertManager showAlert:@"Failed monitoring region" errorMsg:error.description];
        println("Failed monitoring region: \(error)")
    }

    func locationManager(manager: CLLocationManager!, didFailWithError error:NSError!) {
        println("Location manager failed: \(error)");
//        [alertManager showAlert:@"Location manager failed: " errorMsg:error.description];
    }

    func locationManager(manager: CLLocationManager!, didRangeBeacons beacons:NSArray!, inRegion region:CLBeaconRegion!)
    {
//        var beacon:CLBeacon
//        
//        for beacon in beacons {
////            for (BeaconModel item in self.items) {
////                if ([item isEqualToCLBeacon:beacon]) {
////                    item.lastSeenBeacon = beacon;
////                    [self showBeaconInfo:beacon];
////                }
////            }
//        
//        }
        println(beacons)
        
        if(beacons.count == 0) { return }

        var beacon = beacons[0] as CLBeacon
        
        /*
        beacon
        proximityUUID   :   region name
        major           :   id１
        minor           :   id２
        proximity       :   provim
        accuracy        :   acc
        rssi            :   rssi
        */
        if (beacon.proximity == CLProximity.Unknown) {
            println("Unknown Proximity")
//            reset()
            return
        } else if (beacon.proximity == CLProximity.Immediate) {
            println("Immediate")
        } else if (beacon.proximity == CLProximity.Near) {
            println("Near")
        } else if (beacon.proximity == CLProximity.Far) {
            println("Far")
        }
    }
    
    func locationManager(manager: CLLocationManager!, didDetermineState state: CLRegionState, inRegion: CLBeaconRegion!)
    {
        if (state == .Inside) {
            manager.startRangingBeaconsInRegion(inRegion)
            AlertManager.sharedInstance.showAlert("beacon info", msg: "You are inside of beacon range", delegate: nil, btn: "Ok")
        }

//        // Scan our registered notifications to see if this state change
//        // has a user message associated with it
//        NSString * stateStr = @"";
//        
//        switch (state) {
//        case CLRegionStateUnknown:
//        {
//        [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
//        stateStr = @"unknown";
//        break;
//        }
//        case CLRegionStateInside:
//        {
//        [manager startRangingBeaconsInRegion:(CLBeaconRegion*)region];
//        stateStr = @"You are inside of beacon range";
//        break;
//        }
//        case CLRegionStateOutside:
//        {
//        [manager stopRangingBeaconsInRegion:(CLBeaconRegion*)region];
//        stateStr = @"You are outside of beacon range";
//        if(isBeaconAchieved) {
//        isBeaconAchieved = NO;
//        [self.startViewController hideAll];
//        }
//        break;
//        
//        default:
//        break;
//        }
//        }
//        [self.startViewController.rangeStatus setText:stateStr];
    
    }
    
    func startMonitoringItem(/*item: BeaconModel*/)
    {
    
        switch CLLocationManager.authorizationStatus() {
        case .Authorized, .AuthorizedWhenInUse:

            self.locationManager.startRangingBeaconsInRegion(self.beaconRegion)
        case .NotDetermined:
            AlertManager.sharedInstance.showAlert("iBeacon", msg: "RStarting Monitor", delegate: nil, btn: "Ok")
//            if(UIDevice.currentDevice().systemVersion.substringToIndex(1).toInt() >= 8){
//
//                self.locationManager.requestAlwaysAuthorization()
//            }else{
//                self.locationManager.startRangingBeaconsInRegion(self.beaconRegion)
//            }
        case .Restricted, .Denied:

            println("Restricted")
            AlertManager.sharedInstance.showAlert("iBeacon", msg: "Restricted Monitor", delegate: nil, btn: "Ok")
        }
//        self.beaconRegion = [self beaconRegionWithItem:item];
//
//        [self.locationManager startMonitoringForRegion:self.beaconRegion];
//        [self.locationManager startRangingBeaconsInRegion:self.beaconRegion];
//        
//        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    
    }
    
    func stopMonitoringItem()
    {
//        if(!self.beaconRegion)
//        return;
//        
//        [self.locationManager stopMonitoringForRegion:self.beaconRegion];
//        [self.locationManager stopRangingBeaconsInRegion:self.beaconRegion];
    }
    
//Bluetooth Delegate
    func bluetoothReady()
    {
        println("Start of beacons scanning")
//        AlertManager.sharedInstance.showAlert("Bluetooth", msg: "Start of beacons scanning", delegate: nil, btn: "Ok")
        startMonitoringItem()
    }
    
    func bluetoothError(error:String)
    {
        println("Error: \(error)")
//        AlertManager.sharedInstance.showAlert("Bluetooth", msg: "Error: \(error)", delegate: nil, btn: "Ok")
        stopMonitoringItem()
    }
    
}