//
//  SPHomeViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/12/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPActivityViewController.h"


#import "MBProgressHUD.h"
#import "SPFindFriendsViewController.h"

@interface SPActivityViewController ()

@property (nonatomic, strong) UIView *blankTimelineView;
@end

@implementation SPActivityViewController
@synthesize firstLaunch;
@synthesize blankTimelineView;


- (void)viewDidLoad
{
    [super viewDidLoad];

 
    [SPUtility setNavigationBarTintColor:self];
    [self.navigationController.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
    
  
    
      UISegmentedControl *titleViewControl = [[UISegmentedControl alloc] initWithItems:@[@"All",@"Following",@"Spots"]];
    
    
 
    [titleViewControl setWidth:60.0f forSegmentAtIndex:0];
    [titleViewControl setWidth:80.0f forSegmentAtIndex:1];
    [titleViewControl setWidth:73.0f forSegmentAtIndex:2];
 //  self.navigationItem.titleView = titleViewControl;
    [self.navigationItem setTitle:@"Activity"];
    [self.navigationItem.titleView setTintColor:[UIColor whiteColor]];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 50, 20)];
    [lbl setText:@"Activity"];
    [lbl setTextColor:[UIColor whiteColor]];
    [self.navigationItem setTitleView:lbl];
    [titleViewControl addTarget:self
                    action:@selector(action:)
               forControlEvents:UIControlEventValueChanged];
    
    

    
    self.blankTimelineView = [[UIView alloc] initWithFrame:self.tableView.bounds];
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setFrame:CGRectMake(30, 100, 240, 75)];
    UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 250, 75)];
    imgview.contentMode  = UIViewContentModeScaleAspectFit;
    [imgview setImage:[UIImage imageNamed:@"HomeTimelineBlank.png"]];
    [button addSubview:imgview];
 
    
    [button addTarget:self action:@selector(inviteFriendsButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.blankTimelineView addSubview:button];
}

-(void)action:(id)sender{
   
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    NSInteger selectedSegment = segmentedControl.selectedSegmentIndex;
    
    NSLog(@"%i",selectedSegment);
    
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
/* [SP] only keeping for reference, can delete
- (void)settingsButtonAction:(id)sender {
    self.settingsActionSheetDelegate = [[SPSettingsActionSheetDelegate alloc] initWithNavigationController:self.navigationController];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self.settingsActionSheetDelegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"My Profile",@"Find Friends",@"Log Out", nil];
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
}
*/
- (void)inviteFriendsButtonAction:(id)sender {
    

    SPFindFriendsViewController *detailViewController = [[SPFindFriendsViewController alloc] init];
[self.navigationController pushViewController:detailViewController animated:YES];
}



@end
