//
//  SPSettingsActionSheetDelegate.m
//  Spots
//
//  Created by Nicholas Spitale on 7/13/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPSettingsActionSheetDelegate.h"
#import "AppDelegate.h"
#import "SPAccountViewController.h"
#import "SPFindFriendsViewController.h"
// ActionSheet button indexes
typedef enum {
	kSPSettingsProfile = 0,
	kSPSettingsFindFriends,
	kSPSettingsLogout,
    kSPSettingsNumberOfButtons
} kSPSettingsActionSheetButtons;

@implementation SPSettingsActionSheetDelegate


@synthesize navController;

#pragma mark - Initialization

- (id)initWithNavigationController:(UINavigationController *)navigationController {
    self = [super init];
    if (self) {
        navController = navigationController;
    }
    return self;
}

- (id)init {
    return [self initWithNavigationController:nil];
}



#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if (!self.navController) {
        [NSException raise:NSInvalidArgumentException format:@"navController cannot be nil"];
        return;
    }
    
    switch ((kSPSettingsActionSheetButtons)buttonIndex) {
        case kSPSettingsProfile:
        {
            
            
            SPAccountViewController *accountViewController = [[SPAccountViewController alloc] initWithStyle:UITableViewStylePlain];
            [accountViewController setUser:[PFUser currentUser]];
            [navController pushViewController:accountViewController animated:YES];
            
            break;
        }
        case kSPSettingsFindFriends:
        {
            
            
            SPFindFriendsViewController *findFriendsVC = [[SPFindFriendsViewController alloc] init];
            [navController pushViewController:findFriendsVC animated:YES];
            break;
            
        }
        case kSPSettingsLogout:
            // Log out user and present the login view controller
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] logOut];
            break;
        default:
            break;
    }
}

@end
