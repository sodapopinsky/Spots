//
//  SPLeftMenuViewController.m
//  Spots
//
//  Created by Nick Spitale on 8/4/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPLeftMenuViewController.h"
#import "AppDelegate.h"
@interface SPLeftMenuViewController ()

@end

@implementation SPLeftMenuViewController
@synthesize profileImageView;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:kSPColorDarkBlue];
    profileImageView = [[SPProfileImageView alloc] initWithFrame:CGRectMake(90, 50, 95, 95)];
    [self.view addSubview:profileImageView];
    
    if([PFUser currentUser]){
    PFFile *imageFile = [[PFUser currentUser] objectForKey:kSPUserProfilePicMediumKey];
    [profileImageView setFile:imageFile];
    }
    UILabel *name = [[UILabel alloc] initWithFrame:CGRectMake(10, 160, 260, 30)];
    [name setTextColor:[UIColor whiteColor]];
    [name setFont:[UIFont boldSystemFontOfSize:17.0f]];
    [name setText:@"Nick"];
    [name setTextAlignment:NSTextAlignmentCenter];
    [self.view addSubview:name];
    
    UIButton *btnActivity = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *activityImageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 30, 30)];
    UIImage *activity = [UIImage imageNamed:@"sidebarIconActivity"];
    [activityImageview setImage:activity];
    activityImageview.contentMode = UIViewContentModeScaleAspectFit;
    [btnActivity addSubview:activityImageview];
  
    [btnActivity setFrame:CGRectMake(0, 200, 300, 60)];
    [btnActivity setBackgroundColor:[UIColor blackColor]];
    [btnActivity addTarget:self action:@selector(goActivity) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lblActivity = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 100, 35)];
    
    [lblActivity setText:@"Activity"];
    [lblActivity setTextColor:[UIColor whiteColor]];
    [lblActivity setFont:[UIFont systemFontOfSize:16.0f]];
    [btnActivity addSubview:lblActivity];
    [self.view addSubview:btnActivity];
    
    
    
    UIButton *btnSpots = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *spotsImageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 28, 28)];
    UIImage *spots = [UIImage imageNamed:@"sidebarIconSpots"];
    spotsImageview.contentMode = UIViewContentModeScaleAspectFit;
    [spotsImageview setImage:spots];
    [btnSpots addSubview:spotsImageview];
    
    [btnSpots setFrame:CGRectMake(0, 261, 300, 60)];
    [btnSpots setBackgroundColor:[UIColor blackColor]];
    [btnSpots addTarget:self action:@selector(goSpots) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lblspots = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 100, 35)];
    [lblspots setText:@"Spots"];
    [lblspots setTextColor:[UIColor whiteColor]];
    [lblspots setFont:[UIFont systemFontOfSize:16.0f]];
    [btnSpots addSubview:lblspots];
    [self.view addSubview:btnSpots];
    
    
    UIButton *btnlogOut = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImageView *logOutImageview = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 28, 28)];
    logOutImageview.contentMode = UIViewContentModeScaleAspectFit;
    UIImage *logOut = [UIImage imageNamed:@"sidebarIconLogOut"];
    [logOutImageview setImage:logOut];
    [btnlogOut addSubview:logOutImageview];
    
    [btnlogOut setFrame:CGRectMake(0, 322, 300, 60)];
    [btnlogOut setBackgroundColor:[UIColor blackColor]];
    
    UILabel *lbllogOut = [[UILabel alloc] initWithFrame:CGRectMake(60, 13, 100, 35)];
    [lbllogOut setText:@"Log Out"];
    [lbllogOut setTextColor:[UIColor whiteColor]];
    [lbllogOut setFont:[UIFont systemFontOfSize:16.0f]];
    [btnlogOut addSubview:lbllogOut];
    [self.view addSubview:btnlogOut];
    [btnlogOut addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchUpInside];
    
    
    // Do any additional setup after loading the view.
}

-(void)goActivity{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] goActivity];
    
}
-(void)goSpots{
    [(AppDelegate *)[[UIApplication sharedApplication] delegate] goSpots];
    
}
-(void)logOut{
       [(AppDelegate *)[[UIApplication sharedApplication] delegate] logOut];
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
