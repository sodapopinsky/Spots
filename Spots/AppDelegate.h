//
//  AppDelegate.h
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPTabBarController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate,NSURLConnectionDataDelegate, PFLogInViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (nonatomic, strong) SPTabBarController *tabBarController;
@property (nonatomic, strong) UINavigationController *navController;
@property (nonatomic, readonly) int networkStatus;
- (void)presentTabBarController;
- (void)presentLoginViewController;
- (void)presentLoginViewControllerAnimated:(BOOL)animated;
- (void)facebookRequestDidLoad:(id)result;
- (void)facebookRequestDidFailWithError:(NSError *)error;

- (BOOL)isParseReachable;

- (void)logOut;
@end
