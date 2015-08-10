//
//  TActivityIndicatorView.h
//  sportsbook
//
//  Created by Oleg on 7/18/14.
//  Copyright (c) 2014 Oleg. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TActivityIndicatorView : UIView
{
    UIWindow* rootWindow;
}

+ (TActivityIndicatorView*) createActivityIndicatorView;

- (void) present;
- (void) dismiss;

@end
