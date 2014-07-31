//
//  SPMoreNavigationController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPMoreNavigationController.h"
#import "AppDelegate.h"
#import "SPMoreActionSheetDelegate.h"
@interface SPMoreNavigationController ()
@property SPMoreActionSheetDelegate *actionSheetDelegate;
@end

@implementation SPMoreNavigationController
@synthesize actionSheetDelegate;
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
    // Do any additional setup after loading the view.
    
    UIButton *btnLogOut = [[UIButton alloc] initWithFrame:CGRectMake(10, 100, 50, 50)];
    [btnLogOut setBackgroundColor:[UIColor redColor]];
    [btnLogOut setTitle:@"LogOut" forState:UIControlStateNormal];
    
    [self.view addSubview:btnLogOut];
    
    [btnLogOut addTarget:self action:@selector(logOut) forControlEvents:UIControlEventTouchDown];
    
}

-(void)logOut{
    
    self.actionSheetDelegate = [[SPMoreActionSheetDelegate alloc] initWithNavigationController:self.navigationController];
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self.actionSheetDelegate cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"My Profile",@"Find Friends",@"Log Out", nil];
    
    [actionSheet showFromTabBar:self.tabBarController.tabBar];
    /*
      [(AppDelegate *)[[UIApplication sharedApplication] delegate] logOut];*/
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
