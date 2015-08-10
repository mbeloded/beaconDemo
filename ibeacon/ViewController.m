//
//  ViewController.m
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import "ViewController.h"
#import "AppDelegate.h"
#import "BeaconItem.h"

@interface ViewController ()
            

@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.startViewController = self;
    
    [appDelegate addObserver:self forKeyPath:@"item" options:NSKeyValueObservingOptionNew context:nil];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [self hideAll];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    if (/*[object isEqual:self.item.name] &&*/ [keyPath isEqualToString:@"item"]) {
//        NSLog(@"object = %@", object);
        
    }
}

//- (void)registerNotifications
//{
//	[[NSNotificationCenter defaultCenter] addObserverForName:TCSDidEnterBleuRegionNotification object:nil queue:self.opQueue usingBlock:^(NSNotification *note) {
//		NSDictionary *info = [note userInfo];
//		CLBeaconRegion *beaconRegion = info[@"region"];
//		DLog(@"Received Enter Notificationf for beacon %@", beaconRegion.identifier);
//		TCSBleuBeaconManager *manager = [TCSBleuBeaconManager sharedManager];
//		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Entered Region" message:manager.entryText delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//			[alert show];
//		}];
//	}];
//	[[NSNotificationCenter defaultCenter] addObserverForName:TCSDidExitBleuRegionNotification object:nil queue:self.opQueue usingBlock:^(NSNotification *note) {
//		NSDictionary *info = [note userInfo];
//		CLBeaconRegion *beaconRegion = info[@"region"];
//		DLog(@"Received Exit Notificationf for beacon %@", beaconRegion.identifier);
//		TCSBleuBeaconManager *manager = [TCSBleuBeaconManager sharedManager];
//		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//			UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Exited Region" message:manager.exitText delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//			[alert show];
//			self.selectedIndex = 0;
//		}];
//	}];
//	[[NSNotificationCenter defaultCenter] addObserverForName:TCSBleuRangingNotification object:nil queue:self.opQueue usingBlock:^(NSNotification *note) {
//		CLBeacon *beacon = note.userInfo[@"beacon"];
//		DLog(@"%f", beacon.accuracy);
//		NSUInteger index = [note.userInfo[@"index"] unsignedIntegerValue] + 1;
//		if (index == 4) return; //ignore "unknown" proximity
//		[[NSOperationQueue mainQueue] addOperationWithBlock:^{
//			self.selectedIndex = index;
//			//self.accuracyLabel.text = [NSString stringWithFormat:@"%f", beacon.accuracy];
//			CGFloat progress = pow(10.0, beacon.accuracy);
//			DLog(@"Accuracy progress: %f", progress);
//			if (progress > 1.0) progress = 1.0;
//			//[self.progressView setProgress:(1.0 - progress) animated:YES];
//		}];
//	}];
//}


-(void) showGoodBye
{
    self.main.hidden = YES;
    self.btOff.hidden = YES;
    self.rangeStatus.hidden = YES;
    self.infoLabel.hidden = YES;
    self.goodBye.hidden = NO;
    [self hideProdBtn];
}

-(void) showBtOff
{
    self.main.hidden = YES;
    self.btOff.hidden = NO;
    self.goodBye.hidden = YES;
    self.rangeStatus.hidden = YES;
    self.infoLabel.hidden = YES;
    [self hideProdBtn];
}

-(void) hideAll
{
    self.btOff.hidden = YES;
    self.goodBye.hidden = YES;
    self.main.hidden = NO;
    [self hideProdBtn];
}

-(void) showProdBtn
{
    self.prodBtn.hidden = NO;
}

-(void) hideProdBtn
{
    self.prodBtn.hidden = YES;
}

@end
