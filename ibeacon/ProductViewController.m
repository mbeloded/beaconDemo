//
//  ProductViewController.m
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import "ProductViewController.h"
#import "AppDelegate.h"

@interface ProductViewController ()

@property (strong, nonatomic) AppDelegate *appDelegate;

@end

@implementation ProductViewController

- (void)viewWillAppear:(BOOL)animated
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.appDelegate = [[UIApplication sharedApplication] delegate];
    self.appDelegate.prodViewController = self;
    
    self.prodLabel.text = [[NSString alloc] initWithFormat:@"Prod id: %@", self.appDelegate.item.lastSeenBeacon.minor];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)skipAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end