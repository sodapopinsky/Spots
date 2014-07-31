//
//  SPCheckInSelectVisibility.m
//  Spots
//
//  Created by Nicholas Spitale on 12/31/00.
//  Copyright (c) 2000 NickSpitale. All rights reserved.
//

#import "SPCheckInSelectVisibility.h"
#import "SPSelectVisibilityCell.h"
#import "SPLoadMoreCell.h"

typedef enum {
    SPFindFriendsFollowingNone = 0,    // User isn't following anybody in Friends list
    SPFindFriendsFollowingAll,         // User is following all Friends
    SPFindFriendsFollowingSome         // User is following some of their Friends
} SPFindFriendsFollowStatus;

@interface SPCheckInSelectVisibility ()
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, assign) SPFindFriendsFollowStatus followStatus;
@end

@implementation SPCheckInSelectVisibility
@synthesize followStatus;
- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        self.pullToRefreshEnabled = NO;
        self.objectsPerPage = 15;

    }
    return self;
}


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setTitle:@"Select a Spot"];
    self.navigationController.navigationBarHidden = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
  
}


#pragma mark - UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row < self.objects.count) {
        return [SPSelectVisibilityCell heightForCell];
    } else {
        return 44.0f;
    }
}


#pragma mark - PFQueryTableViewController

- (PFQuery *)queryForTable {
    // Use cached facebook friend ids
    NSArray *facebookFriends = [[SPCache sharedCache] facebookFriends];
    
    // Query for all friends you have on facebook and who are using the app
    PFQuery *friendsQuery = [PFUser query];
    [friendsQuery whereKey:kSPUserFacebookIDKey containedIn:facebookFriends];
    
    /*
     // Query for all Parse employees
     NSMutableArray *parseEmployees = [[NSMutableArray alloc] initWithArray:kPAPParseEmployeeAccounts];
     [parseEmployees removeObject:[[PFUser currentUser] objectForKey:kPAPUserFacebookIDKey]];
     PFQuery *parseEmployeeQuery = [PFUser query];
     [parseEmployeeQuery whereKey:kPAPUserFacebookIDKey containedIn:parseEmployees];
     
     // Combine the two queries with an OR
     PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:friendsQuery, parseEmployeeQuery, nil]];
     */
    
    PFQuery *query = friendsQuery;
    
    query.cachePolicy = kPFCachePolicyNetworkOnly;
    
    if (self.objects.count == 0) {
        query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    }
    
    [query orderByAscending:kSPUserDisplayNameKey];
    
    return query;
}

- (void)objectsDidLoad:(NSError *)error {
    
    
    [super objectsDidLoad:error];
    
    PFQuery *isFollowingQuery = [PFQuery queryWithClassName:kSPActivityClassKey];
    [isFollowingQuery whereKey:kSPActivityFromUserKey equalTo:[PFUser currentUser]];
    [isFollowingQuery whereKey:kSPActivityTypeKey equalTo:kSPActivityTypeFollow];
    [isFollowingQuery whereKey:kSPActivityToUserKey containedIn:self.objects];
    [isFollowingQuery setCachePolicy:kPFCachePolicyNetworkOnly];
    
    [isFollowingQuery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
        if (!error) {
            if (number == self.objects.count) {
                self.followStatus = SPFindFriendsFollowingAll;
                [self configureUnfollowAllButton];
                for (PFUser *user in self.objects) {
                    [[SPCache sharedCache] setFollowStatus:YES user:user];
                }
            } else if (number == 0) {
                self.followStatus = SPFindFriendsFollowingNone;
                [self configureFollowAllButton];
                for (PFUser *user in self.objects) {
                    [[SPCache sharedCache] setFollowStatus:NO user:user];
                }
            } else {
                self.followStatus = SPFindFriendsFollowingSome;
                [self configureFollowAllButton];
            }
        }
        
        if (self.objects.count == 0) {
            self.navigationItem.rightBarButtonItem = nil;
        }
    }];
    
    if (self.objects.count == 0) {
        self.navigationItem.rightBarButtonItem = nil;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *FriendCellIdentifier = @"FriendCell";
    
    SPSelectVisibilityCell *cell = [tableView dequeueReusableCellWithIdentifier:FriendCellIdentifier];
    if (cell == nil) {
        cell = [[SPSelectVisibilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:FriendCellIdentifier];
   //     [cell setDelegate:self];
    }
    
    [cell setUser:(PFUser*)object];
    
  
    
 //   NSDictionary *attributes = [[SPCache sharedCache] attributesForUser:(PFUser *)object];
 
    cell.followButton.selected = NO;
    cell.tag = indexPath.row;
    
    /*
    if (self.followStatus == SPFindFriendsFollowingSome) {
        if (attributes) {
            [cell.followButton setSelected:[[SPCache sharedCache] followStatusForUser:(PFUser *)object]];
        } else {
            @synchronized(self) {
                NSNumber *outstandingQuery = [self.outstandingFollowQueries objectForKey:indexPath];
                if (!outstandingQuery) {
                    [self.outstandingFollowQueries setObject:[NSNumber numberWithBool:YES] forKey:indexPath];
                    PFQuery *isFollowingQuery = [PFQuery queryWithClassName:kSPActivityClassKey];
                    [isFollowingQuery whereKey:kSPActivityFromUserKey equalTo:[PFUser currentUser]];
                    [isFollowingQuery whereKey:kSPActivityTypeKey equalTo:kSPActivityTypeFollow];
                    [isFollowingQuery whereKey:kSPActivityToUserKey equalTo:object];
                    [isFollowingQuery setCachePolicy:kPFCachePolicyCacheThenNetwork];
                    
                    [isFollowingQuery countObjectsInBackgroundWithBlock:^(int number, NSError *error) {
                        @synchronized(self) {
                            [self.outstandingFollowQueries removeObjectForKey:indexPath];
                            [[SPCache sharedCache] setFollowStatus:(!error && number > 0) user:(PFUser *)object];
                        }
                        if (cell.tag == indexPath.row) {
                            [cell.followButton setSelected:(!error && number > 0)];
                        }
                    }];
                }
            }
        }
    } else {
        [cell.followButton setSelected:(self.followStatus == SPFindFriendsFollowingAll)];
    }
    */
    return cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *NextPageCellIdentifier = @"NextPageCell";
    
    SPLoadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:NextPageCellIdentifier];
    
    if (cell == nil) {
        cell = [[SPLoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NextPageCellIdentifier];
        [cell.mainView setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"BackgroundFindFriendsCell.png"]]];
        cell.hideSeparatorBottom = YES;
        cell.hideSeparatorTop = YES;
    }
    
    cell.selectionStyle = UITableViewCellSelectionStyleGray;
    
    return cell;
}


- (void)configureUnfollowAllButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Unfollow All" style:UIBarButtonItemStyleBordered target:self action:@selector(unfollowAllFriendsButtonAction:)];
}

- (void)configureFollowAllButton {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Follow All" style:UIBarButtonItemStyleBordered target:self action:@selector(followAllFriendsButtonAction:)];
}

- (void)followAllFriendsButtonAction:(id)sender {
    
}

- (void)unfollowAllFriendsButtonAction:(id)sender {
    
}



@end
