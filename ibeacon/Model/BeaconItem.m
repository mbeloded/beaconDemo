//
//  BeaconItem.m
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import "BeaconItem.h"

static NSString * const beaconItemNameKey = @"name";
static NSString * const beaconItemUUIDKey = @"uuid";
static NSString * const beaconItemMajorValueKey = @"major";
static NSString * const beaconItemMinorValueKey = @"minor";

@implementation BeaconItem

#pragma mark - NSCoding

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (!self) {
        return nil;
    }
    
    _name = [aDecoder decodeObjectForKey:beaconItemNameKey];
    _uuid = [aDecoder decodeObjectForKey:beaconItemUUIDKey];
    _majorValue = [[aDecoder decodeObjectForKey:beaconItemMajorValueKey] unsignedIntegerValue];
    _minorValue = [[aDecoder decodeObjectForKey:beaconItemMinorValueKey] unsignedIntegerValue];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeObject:self.name forKey:beaconItemNameKey];
    [aCoder encodeObject:self.uuid forKey:beaconItemUUIDKey];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.majorValue] forKey:beaconItemMajorValueKey];
    [aCoder encodeObject:[NSNumber numberWithUnsignedInteger:self.minorValue] forKey:beaconItemMinorValueKey];
}


- (BOOL)isEqualToCLBeacon:(CLBeacon *)beacon {
    if ([[beacon.proximityUUID UUIDString] isEqualToString:[self.uuid UUIDString]] &&
        [beacon.major isEqual: @(self.majorValue)] &&
        [beacon.minor isEqual: @(self.minorValue)])
    {
        return YES;
    } else {
        return NO;
    }
}

@end
