//
//  ViewController.h
//  ibeacon
//
//  Created by Migele Beloded on 9/24/14.
//  Copyright (c) 2014 obrichak. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *btOff;
@property (weak, nonatomic) IBOutlet UIImageView *goodBye;
@property (weak, nonatomic) IBOutlet UIImageView *main;
@property (weak, nonatomic) IBOutlet UILabel *infoLabel;
@property (weak, nonatomic) IBOutlet UILabel *rangeStatus;
@property (weak, nonatomic) IBOutlet UIButton *prodBtn;

-(void) showGoodBye;

-(void) showBtOff;

-(void) hideAll;

-(void) showProdBtn;

-(void) hideProdBtn;

@end

