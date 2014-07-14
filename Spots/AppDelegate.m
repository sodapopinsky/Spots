//
//  AppDelegate.m
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "AppDelegate.h"
#import "MBProgressHUD.h"
#import "SPWelcomeViewController.h"
#import "SPHomeViewController.h"
#import "SPLogInViewController.h"
#import "SPDiscoverViewController.h"


@interface AppDelegate () {
    NSMutableData *_data;
    BOOL firstLaunch;
}

@property (nonatomic, strong) SPWelcomeViewController *welcomeViewController;
@property (nonatomic, strong) SPHomeViewController *homeViewController;
@property (nonatomic, strong) SPDiscoverViewController *discoverViewController;
@property (nonatomic, strong) MBProgressHUD *hud;
@property (nonatomic, strong) NSTimer *autoFollowTimer;
- (void)setupAppearance;
@end



@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor redColor];
    
    
    // ****************************************************************************
    // Parse initialization
    [Parse setApplicationId:@"GitsOrpE6s6v4RB30Xrkfjr9LazUrORIZrHcqDGb"
                  clientKey:@"KWZI2125IsHodVq7WlNHukaguohs5uk8QiBrJ6U8"];
    
    [PFFacebookUtils initializeFacebook];
    // ****************************************************************************
    
    PFACL *defaultACL = [PFACL ACL];
    
    // Enable public read access by default, with any newly created PFObjects belonging to the current user
    [defaultACL setPublicReadAccess:YES];
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    [self setupAppearance];
    
    self.welcomeViewController = [[SPWelcomeViewController alloc] init];
    self.navController = [[UINavigationController alloc] initWithRootViewController:self.welcomeViewController];
    self.navController.navigationBarHidden = YES;
    
    self.window.rootViewController = self.navController;
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)presentLoginViewControllerAnimated:(BOOL)animated {
    
    SPLogInViewController *loginViewController = [[SPLogInViewController alloc] init];
    
    [loginViewController setDelegate:self];
    loginViewController.fields = PFLogInFieldsFacebook;
    loginViewController.facebookPermissions = @[ @"user_about_me" ];
    
    [self.welcomeViewController presentViewController:loginViewController animated:NO completion:nil];
    
}


#pragma mark - ()

- (void)setupAppearance {
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
    
    /*
    [[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:0.498f green:0.388f blue:0.329f alpha:1.0f]];
    [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor whiteColor],UITextAttributeTextColor,
                                                          [UIColor colorWithWhite:0.0f alpha:0.750f],UITextAttributeTextShadowColor,
                                                          [NSValue valueWithCGSize:CGSizeMake(0.0f, 1.0f)],UITextAttributeTextShadowOffset,
                                                          nil]];
    */
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"BackgroundNavigationBar.png"] forBarMetrics:UIBarMetricsDefault];
    
    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil] setBackgroundImage:[UIImage imageNamed:@"ButtonNavigationBar.png"] forState:UIControlStateNormal];
    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil] setBackgroundImage:[UIImage imageNamed:@"ButtonNavigationBarSelected.png"] forState:UIControlStateHighlighted];
    [[UIButton appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleColor:[UIColor colorWithRed:214.0f/255.0f green:210.0f/255.0f blue:197.0f/255.0f alpha:1.0f] forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"ButtonBack.png"]
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[UIImage imageNamed:@"ButtonBackSelected.png"]
                                                      forState:UIControlStateSelected
                                                    barMetrics:UIBarMetricsDefault];
    /*
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:214.0f/255.0f green:210.0f/255.0f blue:197.0f/255.0f alpha:1.0f],UITextAttributeTextColor,
                                                          [UIColor colorWithWhite:0.0f alpha:0.750f],UITextAttributeTextShadowColor,
                                                          [NSValue valueWithCGSize:CGSizeMake(0.0f, 1.0f)],UITextAttributeTextShadowOffset,
                                                          nil] forState:UIControlStateNormal];
    */
    [[UISearchBar appearance] setTintColor:[UIColor colorWithRed:32.0f/255.0f green:19.0f/255.0f blue:16.0f/255.0f alpha:1.0f]];
}


- (void)logOut {
    // clear cache
    [[SPCache sharedCache] clear];
    
    
    
    
    
     //clear NSUserDefaults
   [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSPUserDefaultsCacheFacebookFriendsKey];
   // [[NSUserDefaults standardUserDefaults] removeObjectForKey:kSPUserDefaultsActivityFeedViewControllerLastRefreshKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    // Unsubscribe from push notifications by removing the user association from the current installation.
//    [[PFInstallation currentInstallation] removeObjectForKey:kPAPInstallationUserKey];
  //  [[PFInstallation currentInstallation] saveInBackground];
    
    // Clear all caches
    [PFQuery clearAllCachedResults];
    
    // Log out
    [PFUser logOut];
    
    // clear out cached data, view controllers, etc
    [self.navController popToRootViewControllerAnimated:NO];
    
    [self presentLoginViewController];
    
    self.homeViewController = nil;
    self.discoverViewController = nil;
}



#pragma mark - PFLoginViewController

- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
   
    
    // user has logged in - we need to fetch all of their Facebook data before we let them in
    if (![self shouldProceedToMainInterface:user]) {
        
        
        self.hud = [MBProgressHUD showHUDAddedTo:self.navController.presentedViewController.view animated:YES];
        self.hud.labelText = NSLocalizedString(@"Loading", nil);
        self.hud.dimBackground = YES;
        
    }
    
    [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        if (!error) {
            [self facebookRequestDidLoad:result];
        } else {
            [self facebookRequestDidFailWithError:error];
        }
    }];
    
    
}

- (void)presentLoginViewController {
    [self presentLoginViewControllerAnimated:YES];
}


- (BOOL)shouldProceedToMainInterface:(PFUser *)user {
    
    if ([SPUtility userHasValidFacebookData:[PFUser currentUser]]) {
        [MBProgressHUD hideHUDForView:self.navController.presentedViewController.view animated:YES];
        
        [self presentTabBarController];
        
        [self.navController dismissViewControllerAnimated:YES completion:nil];
        return YES;
    }
    return NO;
}



- (void)presentTabBarController {
    
    self.tabBarController = [[SPTabBarController alloc] init];
    self.homeViewController = [[SPHomeViewController alloc] initWithStyle:UITableViewStylePlain];
    self.discoverViewController = [[SPDiscoverViewController alloc] init];
    
    UINavigationController *homeNavigationController = [[UINavigationController alloc] initWithRootViewController:self.homeViewController];
    
     UINavigationController *discoverNavigationController = [[UINavigationController alloc] initWithRootViewController:self.discoverViewController];
    
    [SPUtility addBottomDropShadowToNavigationBarForNavigationController:homeNavigationController];
    
    UITabBarItem *homeTabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Friends", @"Friends") image:nil selectedImage:nil];
    [homeTabBarItem setTitleTextAttributes: @{ NSForegroundColorAttributeName: [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] } forState:UIControlStateNormal];
    [homeTabBarItem setTitleTextAttributes: @{ NSForegroundColorAttributeName: [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] } forState:UIControlStateSelected];
    [homeTabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -20)];
    
    [homeNavigationController setTabBarItem:homeTabBarItem];
    
    UITabBarItem *discoverTabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Discover", @"Discover") image:nil selectedImage:nil];
    [discoverTabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] } forState:UIControlStateNormal];
    [discoverTabBarItem setTitleTextAttributes:@{ NSForegroundColorAttributeName: [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f] } forState:UIControlStateSelected];
    [discoverTabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -20)];
    
    [discoverNavigationController setTabBarItem:discoverTabBarItem];
    
    self.tabBarController.tabBar.barTintColor =  [UIColor colorWithRed:20.0f/255.0f green:126.0f/255.0f blue:187.0f/255.0f alpha:1.000];
    
    
    self.tabBarController.delegate = self;
    self.tabBarController.viewControllers = @[ homeNavigationController, discoverNavigationController];
    
    [self.navController setViewControllers:@[ self.welcomeViewController, self.tabBarController ] animated:NO];
    
}

- (void)autoFollowTimerFired:(NSTimer *)aTimer {
    [MBProgressHUD hideHUDForView:self.navController.presentedViewController.view animated:YES];
    [MBProgressHUD hideHUDForView:self.homeViewController.view animated:YES];
    [self.homeViewController loadObjects];
}

#pragma mark -- Facebook Methods
- (void)facebookRequestDidLoad:(id)result {
    
    
    // This method is called twice - once for the user's /me profile, and a second time when obtaining their friends. We will try and handle both scenarios in a single method.
    PFUser *user = [PFUser currentUser];
    
    NSArray *data = [result objectForKey:@"data"];
    NSLog(@"%@",data);
    if (data) {
        // we have friends data
        NSMutableArray *facebookIds = [[NSMutableArray alloc] initWithCapacity:[data count]];
        for (NSDictionary *friendData in data) {
            if (friendData[@"id"]) {
                [facebookIds addObject:friendData[@"id"]];
            }
        }
        
        // cache friend data
        [[SPCache sharedCache] setFacebookFriends:facebookIds];
        
        if (user) {
            if ([user objectForKey:kSPUserFacebookFriendsKey]) {
                [user removeObjectForKey:kSPUserFacebookFriendsKey];
            }
            
            if (![user objectForKey:kSPUserAlreadyAutoFollowedFacebookFriendsKey]) {
                self.hud.labelText = NSLocalizedString(@"Following Friends", nil);
                firstLaunch = YES;
                
                [user setObject:@YES forKey:kSPUserAlreadyAutoFollowedFacebookFriendsKey];
                NSError *error = nil;
                
                // find common Facebook friends already using Anypic
                PFQuery *facebookFriendsQuery = [PFUser query];
                [facebookFriendsQuery whereKey:kSPUserFacebookIDKey containedIn:facebookIds];
                
                // auto-follow Parse employees
            //    PFQuery *parseEmployeesQuery = [PFUser query];
            //    [parseEmployeesQuery whereKey:kSPUserFacebookIDKey containedIn:kPAPParseEmployeeAccounts];
                
                // combined query
                PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:facebookFriendsQuery, nil]];
                
                NSArray *anypicFriends = [query findObjects:&error];
                
                if (!error) {
                    [anypicFriends enumerateObjectsUsingBlock:^(PFUser *newFriend, NSUInteger idx, BOOL *stop) {
                        PFObject *joinActivity = [PFObject objectWithClassName:kSPActivityClassKey];
                        [joinActivity setObject:user forKey:kSPActivityFromUserKey];
                        [joinActivity setObject:newFriend forKey:kSPActivityToUserKey];
                        [joinActivity setObject:kSPActivityTypeJoined forKey:kSPActivityTypeKey];
                        
                        PFACL *joinACL = [PFACL ACL];
                        [joinACL setPublicReadAccess:YES];
                        joinActivity.ACL = joinACL;
                        
                        // make sure our join activity is always earlier than a follow
                        [joinActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                            [SPUtility followUserInBackground:newFriend block:^(BOOL succeeded, NSError *error) {
                                // This block will be executed once for each friend that is followed.
                                // We need to refresh the timeline when we are following at least a few friends
                                // Use a timer to avoid refreshing innecessarily
                                if (self.autoFollowTimer) {
                                    [self.autoFollowTimer invalidate];
                                }
                                
                                self.autoFollowTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f target:self selector:@selector(autoFollowTimerFired:) userInfo:nil repeats:NO];
                                
                            }];
                        }];
                    }];
                }
                
                if (![self shouldProceedToMainInterface:user]) {
                    [self logOut];
                    return;
                }
                
                if (!error) {
                    [MBProgressHUD hideHUDForView:self.navController.presentedViewController.view animated:NO];
                    if (anypicFriends.count > 0) {
                        self.hud = [MBProgressHUD showHUDAddedTo:self.homeViewController.view animated:NO];
                        self.hud.dimBackground = YES;
                        self.hud.labelText = NSLocalizedString(@"Following Friends", nil);
                    } else {
                        [self.homeViewController loadObjects];
                    }
                }
            }
            
            [user saveEventually];
        } else {
            NSLog(@"No user session found. Forcing logOut.");
            [self logOut];
        }
    } else {
        self.hud.labelText = NSLocalizedString(@"Creating Profile", nil);
        
        if (user) {
            NSString *facebookName = result[@"name"];
            if (facebookName && [facebookName length] != 0) {
                [user setObject:facebookName forKey:kSPUserDisplayNameKey];
            } else {
                [user setObject:@"Someone" forKey:kSPUserDisplayNameKey];
            }
            
            NSString *facebookId = result[@"id"];
            if (facebookId && [facebookId length] != 0) {
                [user setObject:facebookId forKey:kSPUserFacebookIDKey];
            }
            
            [user saveEventually];
        }
        
        [FBRequestConnection startForMyFriendsWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            if (!error) {
                [self facebookRequestDidLoad:result];
            } else {
                [self facebookRequestDidFailWithError:error];
            }
        }];
    }

    
    
}

- (void)facebookRequestDidFailWithError:(NSError *)error {
    NSLog(@"Facebook error: %@", error);
    
    if ([PFUser currentUser]) {
        if ([[error userInfo][@"error"][@"type"] isEqualToString:@"OAuthException"]) {
            NSLog(@"The Facebook token was invalidated. Logging out.");
          //  [self logOut];
        }
    }
}


@end