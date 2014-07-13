//
//  SPTabBarControllerViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/12/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPTabBarController.h"

@interface SPTabBarController ()
@property (nonatomic,strong) UINavigationController *navController;
@end

@implementation SPTabBarController
@synthesize navController;


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[self tabBar] setBackgroundImage:[UIImage imageNamed:@"BackgroundTabBar.png"]];
    //    [[self tabBar] setSelectionIndicatorImage:[UIImage imageNamed:@"BackgroundTabBarItemSelected.png"]];
  //  self.tabBar.tintColor = [UIColor colorWithRed:139.0f/255.0f green:111.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
    
    /*
     // iOS 7 style
     self.tabBar.tintColor = [UIColor colorWithRed:139.0f/255.0f green:111.0f/255.0f blue:95.0f/255.0f alpha:1.0f];
     self.tabBar.barTintColor = [UIColor colorWithRed:77.0f/255.0f green:49.0f/255.0f blue:37.0f/255.0f alpha:1.0f];
     */
    self.navController = [[UINavigationController alloc] init];
    [SPUtility addBottomDropShadowToNavigationBarForNavigationController:self.navController];
}



@end
