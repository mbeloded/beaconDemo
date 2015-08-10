//
//  TAlertManager.m
//  sportsbook
//
//  Created by Oleg on 4/28/14.
//  Copyright (c) 2014 Beeplex. All rights reserved.
//

#import "TAlertManager.h"

static TAlertManager * sharedInstance;

@implementation TAlertManager

+(TAlertManager*) sharedTAlertManager
{
    if (!sharedInstance) {
        sharedInstance = [[TAlertManager alloc] init];
    }
    
    return sharedInstance;
}

-(id) init
{
    if (self == [super init]) {
        
    }
    
    return self;
}

- (void) showWaitIndicator
{
    if (activityIndicator)
    {
        [self dismissWaitIndicator];
    }
    
    activityIndicator = [TActivityIndicatorView createActivityIndicatorView];
    [activityIndicator present];
}

- (void) dismissWaitIndicator
{
    [activityIndicator dismiss];
    activityIndicator = nil;
}

-(void)showWaitMsg: (NSString*) title
{
    [self dismissWaitIndicator];
    
    if(!title)
        title = NSLocalizedString(@"Please wait...",);
    
    if (altpleasewait && altpleasewait.isVisible) {
        [self dismissWaitMsg];
    }
    
    altpleasewait = [[UIAlertView alloc] initWithTitle:title message:nil delegate:self cancelButtonTitle:nil otherButtonTitles: nil];
    
    [altpleasewait show];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    
    if(!xPos)
        xPos = altpleasewait.bounds.size.width / 2;
    
    if(!yPos)
        yPos = altpleasewait.bounds.size.height - 50;
    
    indicator.center = CGPointMake(xPos, yPos);
    [indicator startAnimating];
    [altpleasewait addSubview:indicator];
    
}

-(void)dismissWaitMsg
{
    [self dismissWaitIndicator];
    [altpleasewait dismissWithClickedButtonIndex:0 animated:YES];
}

-(void) showAlert:(NSString *)title {
    [self showAlert:title errorMsg:nil];
}

-(void) showAlert:(NSString *)title errorMsg:(NSString*)msg {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:NSLocalizedString(@"Ok", )
                                          otherButtonTitles:nil, nil];
    [alert setAlertViewStyle:UIAlertViewStyleDefault];
    [alert show];
}

-(void) showAlert:(NSString *)title errorMsg:(NSString *)msg delegate:(id) _delegate cancelBtn:(NSString*) cancel otherBtn:(NSString*) other
{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:title
                                                    message:msg
                                                   delegate:_delegate
                                          cancelButtonTitle:cancel
                                          otherButtonTitles:other, nil];
    [alert setAlertViewStyle:UIAlertViewStyleDefault];
    [alert show];
}

@end
