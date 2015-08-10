//
//  BluetoothManager.h
//  ibeacon
//
//  Created by Migele Beloded on 9/26/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreBluetooth/CoreBluetooth.h>

@interface BluetoothManager : NSObject <CBCentralManagerDelegate>

-(instancetype) sharedManager;

@end
