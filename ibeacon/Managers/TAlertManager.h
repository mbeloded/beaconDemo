//
//  TAlertManager.h
//  sportsbook
//
//  Created by Oleg on 4/28/14.
//  Copyright (c) 2014 Oleg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TActivityIndicatorView.h"

@interface TAlertManager : NSObject
{
    TActivityIndicatorView* activityIndicator;
    
    UIAlertView     * altpleasewait;
    float xPos;
    float yPos;
}

+ (TAlertManager*) sharedTAlertManager;

-(void)showAlert: (NSString*) title;
-(void)showAlert: (NSString *) title errorMsg:(NSString*)msg;
-(void)showWaitMsg: (NSString*) title;
-(void)showAlert: (NSString *)title errorMsg:(NSString *)msg delegate:(id) _delegate cancelBtn:(NSString*) cancel otherBtn:(NSString*) other;
-(void)dismissWaitMsg;

- (void) showWaitIndicator;
- (void) dismissWaitIndicator;

@end
