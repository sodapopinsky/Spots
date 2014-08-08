//
//  AppDelegate.h
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPTabBarController.h"

@class IIViewDeckController;
@interface AppDelegate : UIResponder <UIApplicationDelegate,NSURLConnectionDataDelegate, PFLogInViewControllerDelegate>

@property (strong, nonatomic) UIWindow *window;


@property (nonatomic, strong) UINavigationController *navController;
@property (retain, nonatomic) UIViewController *leftController;
@property (nonatomic, retain) IIViewDeckController* deckController;


- (void)generateUserStack;
@property (nonatomic, readonly) int networkStatus;
- (void)proceedToMainInterface;
- (void)presentLoginViewController;
//- (void)presentLoginViewControllerAnimated:(BOOL)animated;
- (void)facebookRequestDidLoad:(id)result;
- (void)facebookRequestDidFailWithError:(NSError *)error;

- (BOOL)isParseReachable;

- (void)logOut;
@end
