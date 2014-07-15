//
//  SPFindFriendsViewController.h
//  Spots
//
//  Created by Nicholas Spitale on 7/15/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//


#import <AddressBookUI/AddressBookUI.h>
#import <MessageUI/MessageUI.h>
#import "SPFindFriendsCell.h"

@interface SPFindFriendsViewController : PFQueryTableViewController <SPFindFriendsCellDelegate, ABPeoplePickerNavigationControllerDelegate, MFMailComposeViewControllerDelegate, MFMessageComposeViewControllerDelegate, UIActionSheetDelegate>

@end
