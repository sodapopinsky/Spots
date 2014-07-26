//
//  SPTimelineViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/13/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPTimelineViewController.h"
#import "SPAccountViewController.h"
//#import "SPPhotoDetailsViewController.h"
#import "SPUtility.h"
#import "SPLoadMoreCell.h"
#import "AppDelegate.h"
#import "TTTTimeIntervalFormatter.h"

@interface SPTimelineViewController ()
@property (nonatomic, assign) BOOL shouldReloadOnAppear;
@property (nonatomic, strong) NSMutableSet *reusableSectionHeaderViews;
@property (nonatomic, strong) NSMutableDictionary *outstandingSectionHeaderQueries;
@end

@implementation SPTimelineViewController
@synthesize reusableSectionHeaderViews;
@synthesize shouldReloadOnAppear;
@synthesize outstandingSectionHeaderQueries;

- (void)dealloc {
    
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPTabBarControllerDidFinishEditingPhotoNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPUtilityUserFollowingChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPPhotoDetailsViewControllerUserCommentedOnPhotoNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:SPPhotoDetailsViewControllerUserDeletedPhotoNotification object:nil];
    
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        
        self.outstandingSectionHeaderQueries = [NSMutableDictionary dictionary];
        
        // The className to query on
        self.parseClassName = kSPPhotoClassKey;
        // Whether the built-in pull-to-refresh is enabled
        self.pullToRefreshEnabled = YES;
        
        // Whether the built-in pagination is enabled
        self.paginationEnabled = YES;
        
        // The number of objects to show per page
        self.objectsPerPage = 10;
        
        // Improve scrolling performance by reusing UITableView section headers
        self.reusableSectionHeaderViews = [NSMutableSet setWithCapacity:3];
        
        self.shouldReloadOnAppear = NO;
    }
    return self;
}

#pragma mark - UIViewController

- (void)viewDidLoad {

    
    // PFQueryTableViewController reads this in viewDidLoad -- would prefer to throw this in init, but didn't work

    [super viewDidLoad];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[SP] This shouldnt be necessary, how to disable seperator line?
    [self.tableView setSeparatorColor:[UIColor whiteColor]];
    
    self.tableView.backgroundColor = [UIColor colorWithRed:221.0f/255.0f green:221.0f/255.0f  blue:221.0f/255.0f  alpha:1.0f];
    [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
   // [self.tableView setContentInset:UIEdgeInsetsMake(10.0f, 0.0f, 0.0f, 0.0f)];
    /*
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidPublishPhoto:) name:SPTabBarControllerDidFinishEditingPhotoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userFollowingChanged:) name:SPUtilityUserFollowingChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidDeletePhoto:) name:SPPhotoDetailsViewControllerUserDeletedPhotoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLikeOrUnlikePhoto:) name:SPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidLikeOrUnlikePhoto:) name:SPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userDidCommentOnPhoto:) name:SPPhotoDetailsViewControllerUserCommentedOnPhotoNotification object:nil];
    */
  
    
    
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    if (self.shouldReloadOnAppear) {
        self.shouldReloadOnAppear = NO;
        [self loadObjects];
    }
}


#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    NSInteger sections = self.objects.count;
    if (self.paginationEnabled && sections != 0)
        sections++;
    return sections;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}



#pragma mark - UITableViewDelegate
/*
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {

    if (section == self.objects.count) {
        // Load More section
        return nil;
        
    }
    
    
    
    SPTimelineHeaderView *headerView = [self dequeueReusableSectionHeaderView];
    
    if (!headerView) {
        headerView = [[SPTimelineHeaderView alloc] initWithFrame:CGRectMake( 0.0f, 0.0f, self.view.bounds.size.width, 80.0f) buttons:SPTimelineHeaderButtonsUser];
        headerView.delegate = self;
        [self.reusableSectionHeaderViews addObject:headerView];
    }
    
    [headerView setPhoto:[self.objects objectAtIndex:section]];
    headerView.tag = section;
    
   // NSLog(@"%@",[self.objects objectAtIndex:section]);
    
 
        
        // This does not require a network access.
    
       // NSLog(@"%@",[band objectForKey:@"displayName"]);
    [headerView setPhoto:[self.objects objectAtIndex:section]];
    headerView.tag = section;
   
      [SP] ALL OF THIS HAS TO DO WITH HEADER VIEW ITEMS WHICH WE ARENT CURRENTLY USING
    [headerView.likeButton setTag:section];
    NSDictionary *attributesForPhoto = [[SPCache sharedCache] attributesForPhoto:photo];
    
    if (attributesForPhoto) {
        [headerView setLikeStatus:[[PAPCache sharedCache] isPhotoLikedByCurrentUser:photo]];
        [headerView.likeButton setTitle:[[[PAPCache sharedCache] likeCountForPhoto:photo] description] forState:UIControlStateNormal];
        [headerView.commentButton setTitle:[[[PAPCache sharedCache] commentCountForPhoto:photo] description] forState:UIControlStateNormal];
        
        if (headerView.likeButton.alpha < 1.0f || headerView.commentButton.alpha < 1.0f) {
            [UIView animateWithDuration:0.200f animations:^{
                headerView.likeButton.alpha = 1.0f;
                headerView.commentButton.alpha = 1.0f;
            }];
        }
    } else {
        headerView.likeButton.alpha = 0.0f;
        headerView.commentButton.alpha = 0.0f;
        
        @synchronized(self) {
            // check if we can update the cache
            NSNumber *outstandingSectionHeaderQueryStatus = [self.outstandingSectionHeaderQueries objectForKey:[NSNumber numberWithInt:section]];
            if (!outstandingSectionHeaderQueryStatus) {
                PFQuery *query = [PAPUtility queryForActivitiesOnPhoto:photo cachePolicy:kPFCachePolicyNetworkOnly];
                [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    @synchronized(self) {
                        [self.outstandingSectionHeaderQueries removeObjectForKey:[NSNumber numberWithInt:section]];
                        
                        if (error) {
                            return;
                        }
                        
                        NSMutableArray *likers = [NSMutableArray array];
                        NSMutableArray *commenters = [NSMutableArray array];
                        
                        BOOL isLikedByCurrentUser = NO;
                        
                        for (PFObject *activity in objects) {
                            if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike] && [activity objectForKey:kPAPActivityFromUserKey]) {
                                [likers addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                            } else if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeComment] && [activity objectForKey:kPAPActivityFromUserKey]) {
                                [commenters addObject:[activity objectForKey:kPAPActivityFromUserKey]];
                            }
                            
                            if ([[[activity objectForKey:kPAPActivityFromUserKey] objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
                                if ([[activity objectForKey:kPAPActivityTypeKey] isEqualToString:kPAPActivityTypeLike]) {
                                    isLikedByCurrentUser = YES;
                                }
                            }
                        }
                        
                        [[PAPCache sharedCache] setAttributesForPhoto:photo likers:likers commenters:commenters likedByCurrentUser:isLikedByCurrentUser];
                        
                        if (headerView.tag != section) {
                            return;
                        }
                        
                        [headerView setLikeStatus:[[PAPCache sharedCache] isPhotoLikedByCurrentUser:photo]];
                        [headerView.likeButton setTitle:[[[PAPCache sharedCache] likeCountForPhoto:photo] description] forState:UIControlStateNormal];
                        [headerView.commentButton setTitle:[[[PAPCache sharedCache] commentCountForPhoto:photo] description] forState:UIControlStateNormal];
                        
                        if (headerView.likeButton.alpha < 1.0f || headerView.commentButton.alpha < 1.0f) {
                            [UIView animateWithDuration:0.200f animations:^{
                                headerView.likeButton.alpha = 1.0f;
                                headerView.commentButton.alpha = 1.0f;
                            }];
                        }
                    }
                }];
            }
        }
    }
 
    return headerView;
    
  
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == self.objects.count) {
        return 0.0f;
    }
    return 80.0f;
}
   */
/*
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake( 0.0f, 0.0f, self.tableView.bounds.size.width, 16.0f)];
    return footerView;
}


- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.objects.count) {
        return 0.0f;
    }
    return 16.0f;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    if (section == self.objects.count) {
        return 0.0f;
    }
    return 0.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == self.objects.count) {
        return 0.0f;
    }
    return 0.0f;
}
*/
#pragma mark - PFQueryTableViewController

- (PFQuery *)queryForTable {
    if (![PFUser currentUser]) {
        PFQuery *query = [PFQuery queryWithClassName:self.parseClassName];
        [query setLimit:0];
        return query;
    }
    
    PFQuery *followingActivitiesQuery = [PFQuery queryWithClassName:kSPActivityClassKey];
    [followingActivitiesQuery whereKey:kSPActivityTypeKey equalTo:kSPActivityTypeFollow];
    [followingActivitiesQuery whereKey:kSPActivityToUserKey equalTo:[PFUser currentUser]];
    followingActivitiesQuery.limit = 1000;
    
    PFQuery *checkinsFromBroadcastingUsersQuery = [PFQuery queryWithClassName:kSPCheckInClassKey];
    [checkinsFromBroadcastingUsersQuery whereKey:kSPCheckInUserKey matchesKey:kSPActivityFromUserKey inQuery:followingActivitiesQuery];
   // [checkinsFromBroadcastingUsersQuery includeKey:kSPCheckInUserKey];
    
    PFQuery *myCheckins = [PFQuery queryWithClassName:kSPCheckInClassKey];
    [myCheckins whereKey:kSPCheckInUserKey equalTo:[PFUser currentUser]];

    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:checkinsFromBroadcastingUsersQuery,myCheckins, nil]];
   

   //[query includeKey:kSPUserProfilePicSmallKey];

   [query includeKey:kSPCheckInUserKey];
  
    [query orderByDescending:@"createdAt"];
 return query;
    // If no objects are loaded in memory, we look to the cache first to fill the table
    // and then subsequently do a query against the network.
    //
    // If there is no network connection, we will hit the cache first.

    
    
    if (self.objects.count == 0 || ![[UIApplication sharedApplication].delegate performSelector:@selector(isParseReachable)]) {
        [query setCachePolicy:kPFCachePolicyCacheThenNetwork];
    }
    

}


- (PFObject *)objectAtIndex:(NSIndexPath *)indexPath {
    // overridden, since we want to implement sections
    if (indexPath.section < self.objects.count) {
        return [self.objects objectAtIndex:indexPath.section];
    }
    
    return nil;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section >= self.objects.count) {
        // Load More Section
        return 44.0f;
    }
    
    PFObject *result = [self.objects objectAtIndex:indexPath.section];
    NSString *comment =[result objectForKey:kSPCheckInCommentsKey];
    if((comment.length) <= 0){
        return 80.0f;
    }
    return 130.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.section == self.objects.count && self.paginationEnabled) {
        // Load More Cell
        [self loadNextPage];
    }
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object {
    static NSString *CellIdentifier = @"Cell";
  
    if (indexPath.section == self.objects.count) {
        // this behavior is normally handled by PFQueryTableViewController, but we are using sections for each object and we must handle this ourselves
        UITableViewCell *cell = [self tableView:tableView cellForNextPageAtIndexPath:indexPath];
        return cell;
    } else {
        SPActivityCell *cell = (SPActivityCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        if (cell == nil) {
            cell = [[SPActivityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        
        [cell setDelegate:self];
        PFObject *result = [self.objects objectAtIndex:indexPath.section];
        PFObject *user = [result objectForKey:@"user"];
        cell.user = [result objectForKey:kSPCheckInUserKey];
        [cell.userButton setTitle:[user objectForKey:kSPUserDisplayNameKey] forState:UIControlStateNormal];
        [cell.placeButton setTitle:[result objectForKey:kSPCheckInPlaceNameKey] forState:UIControlStateNormal];


        
        TTTTimeIntervalFormatter *timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
        //NSTimeInterval timeInterval = [[result createdAt] timeIntervalSinceNow];
        NSTimeInterval timeInterval = [[result createdAt] timeIntervalSinceNow];
        NSString *timestamp = [timeIntervalFormatter stringForTimeInterval:timeInterval];
        cell.timeLabel.text = timestamp;
       
      //  NSLog(@"%@",[user objectForKey:kSPUserProfilePicMediumKey]);
        
        PFFile *profilePictureSmall = [user objectForKey:kSPUserProfilePicSmallKey];
        [cell.userImageView setFile:profilePictureSmall];
        
   
        
        
        NSString *comment =[result objectForKey:kSPCheckInCommentsKey];
        if((comment.length) > 0){
  
            [cell.contentView addSubview:cell.commentView];
            //draw comment triangle
            CGMutablePathRef path = CGPathCreateMutable();
            CGPathMoveToPoint(path,NULL,0.0,0.0);
            CGPathAddLineToPoint(path, NULL, 20.0f, 0.0f);
            CGPathAddLineToPoint(path, NULL, 10.0f, -10.0f);
            CGPathAddLineToPoint(path, NULL, 0.0f, 0.0f);
            
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            [shapeLayer setPath:path];
            [shapeLayer setFillColor:[[UIColor whiteColor] CGColor]];
            [shapeLayer setStrokeColor:[[UIColor whiteColor] CGColor]];
            [shapeLayer setBounds:CGRectMake(0.0f, 0.0f, 160.0f, 480)];
            [shapeLayer setAnchorPoint:CGPointMake(0.0f, 0.0f)];
            [shapeLayer setPosition:CGPointMake(25.0f, 3.0f)];
            [[cell.commentView layer] addSublayer:shapeLayer];
            
        }
        
        [cell.comments setText:[result objectForKey:kSPCheckInCommentsKey]];
        
        //Reset widths to avoid having large touch area
        NSDictionary *attributes = @{NSFontAttributeName: cell.userButton.titleLabel.font};
        CGSize textSize = [cell.userButton.titleLabel.text sizeWithAttributes:attributes];
        [cell.userButton setFrame:CGRectMake(cell.userButton.frame.origin.x, cell.userButton.frame.origin.y, textSize.width, cell.userButton.frame.size.height)];
        
        //Reset widths to avoid having large touch area
        attributes = @{NSFontAttributeName: cell.placeButton.titleLabel.font};
        textSize = [cell.placeButton.titleLabel.text sizeWithAttributes:attributes];
        [cell.placeButton setFrame:CGRectMake(cell.placeButton.frame.origin.x, cell.placeButton.frame.origin.y, textSize.width + 10, cell.placeButton.frame.size.height)];

        return cell;
    }
}


- (void)cell:(SPActivityCell *)cellView didTapUserButton:(PFUser *)user {
  
SPAccountViewController *accountViewController = [[SPAccountViewController alloc] initWithStyle:UITableViewStylePlain];
    [accountViewController setUser:user];
    [self.navigationController pushViewController:accountViewController animated:YES];
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForNextPageAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *LoadMoreCellIdentifier = @"LoadMoreCell";
    
    SPLoadMoreCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadMoreCellIdentifier];
    if (!cell) {
        cell = [[SPLoadMoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadMoreCellIdentifier];
        cell.selectionStyle =UITableViewCellSelectionStyleGray;
        cell.separatorImageTop.image = [UIImage imageNamed:@"SeparatorTimelineDark.png"];
        cell.hideSeparatorBottom = YES;
        cell.mainView.backgroundColor = [UIColor clearColor];
    }
    
    return cell;
}



#pragma mark - PAPPhotoTimelineViewController
/*
- (SPTimelineHeaderView *)dequeueReusableSectionHeaderView {
    for (SPTimelineHeaderView *sectionHeaderView in self.reusableSectionHeaderViews) {
        if (!sectionHeaderView.superview) {
            // we found a section header that is no longer visible
            return sectionHeaderView;
        }
    }
    
    return nil;
}
*/
@end
