//
//  AppDelegate.h
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
#import "ProductViewController.h"
#import "BeaconItem.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (weak, nonatomic) ProductViewController *prodViewController;
@property (weak, nonatomic) ViewController *startViewController;

@property (strong, nonatomic) BeaconItem* item;

@end

