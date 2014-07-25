//
//  SPHomeViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/12/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPHomeViewController.h"
#import "SPSettingsActionSheetDelegate.h"
#import "SPSettingsButtonItem.h"
#import "MBProgressHUD.h"
#import "SPFindFriendsViewController.h"

@interface SPHomeViewController ()
@property (nonatomic, strong) SPSettingsActionSheetDelegate *settingsActionSheetDelegate;
@property (nonatomic, strong) UIView *blankTimelineView;
@end

@implementation SPHomeViewController
@synthesize firstLaunch;
@synthesize blankTimelineView;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [SPUtility setNavigationBarTintColor:self];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoNavigationBar.png"]];
    
    self.navigationItem.rightBarButtonItem = [[SPSettingsButtonItem alloc] initWithTarget:self action:@selector(settingsButtonAction:)];
    
    self.blankTimelineView = [[UIView alloc] initWithFrame:self.tableView.bounds];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake( 33.0f, 96.0f, 253.0f, 173.0f);
    [button setBackgroundImage:[UIImage imageNamed:@"HomeTimelineBlank.png"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(inviteFriendsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.blankTimelineView addSubview:button];
}



#pragma mark - PFQueryTableViewController

- (void)objectsDidLoad:(NSError *)error {
    [super objectsDidLoad:error];
    
    if(self.objects.count == 0){
        
        
    }
    if (self.objects.count == 0 && ![[self queryForTable] hasCachedResult] & !self.firstLaunch) {
        
        self.tableView.scrollEnabled = NO;
        
        if (!self.blankTimelineView.superview) {
            self.blankTimelineView.alpha = 0.0f;
            self.tableView.tableHeaderView = self.blankTimelineView;
            
            [UIView animateWithDuration:0.200f animations:^{
                self.blankTimelineView.alpha = 1.0f;
            }];
        }
    } else {
        self.tableView.tableHeaderView = nil;
        self.tableView.scrollEnabled = YES;
    }
}


#pragma mark - ()

- (void)settingsButtonAction:(id)sender {
    self.settingsActionSheetDelegate = [[SPSettingsActionSheetDelegate alloc] initWithNavigationController:self.navigationController];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self.settingsActionSheetDelegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"My Profile",@"Find Friends",@"Log Out", nil];
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)inviteFriendsButtonAction:(id)sender {
    

    SPFindFriendsViewController *detailViewController = [[SPFindFriendsViewController alloc] init];
[self.navigationController pushViewController:detailViewController animated:YES];
}

@end
