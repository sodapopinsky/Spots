//
//  AppDelegate.h
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, PFLogInViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) UINavigationController *navController;
- (void)presentTabBarController;
- (void)presentLoginViewControllerAnimated:(BOOL)animated;
- (void)facebookRequestDidLoad:(id)result;
- (void)facebookRequestDidFailWithError:(NSError *)error;
@end
