//
//  SPSettingsActionSheetDelegate.m
//  Spots
//
//  Created by Nicholas Spitale on 7/13/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPSettingsActionSheetDelegate.h"
#import "AppDelegate.h"

// ActionSheet button indexes
typedef enum {
	kPAPSettingsProfile = 0,
	kPAPSettingsFindFriends,
	kPAPSettingsLogout,
    kPAPSettingsNumberOfButtons
} kPAPSettingsActionSheetButtons;

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
    
    switch ((kPAPSettingsActionSheetButtons)buttonIndex) {
        case kPAPSettingsProfile:
        {
            
            /*
            PAPAccountViewController *accountViewController = [[PAPAccountViewController alloc] initWithStyle:UITableViewStylePlain];
            [accountViewController setUser:[PFUser currentUser]];
            [navController pushViewController:accountViewController animated:YES];
             */
            break;
        }
        case kPAPSettingsFindFriends:
        {
            
            /*
            PAPFindFriendsViewController *findFriendsVC = [[PAPFindFriendsViewController alloc] init];
            [navController pushViewController:findFriendsVC animated:YES];
            break;
             */
        }
        case kPAPSettingsLogout:
            // Log out user and present the login view controller
            [(AppDelegate *)[[UIApplication sharedApplication] delegate] logOut];
            break;
        default:
            break;
    }
}

@end
