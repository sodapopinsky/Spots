//
//  SPCheckinCommentsViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/17/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//
#define numLikePics 7.0f
#define likeProfileXBase 46.0f
#define likeProfileXSpace 3.0f
#define likeProfileY 6.0f
#define likeProfileDim 30.0f

#import "SPCheckinCommentsViewController.h"
#import "SPProfileImageView.h"
@interface SPCheckinCommentsViewController ()
@property (nonatomic, retain) NSDictionary* place;
@property (nonatomic, assign) BOOL broadcastingToQueryInProgress;
@property (nonatomic, strong) UITextView *commentTextField;
@end

@implementation SPCheckinCommentsViewController
@synthesize place, commentTextField;
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
  self.navigationController.navigationBar.topItem.title = @"";
  self.title = [place objectForKey:@"name"];
   
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"do" style:UIBarButtonItemStyleBordered target:self action:@selector(doCheckin)];

    
    [self.view setBackgroundColor:[UIColor colorWithRed:246.0f/255.0f green:246.0f/255.0f blue:246.0f/255.0f alpha:1.0]];
        self.view.layer.cornerRadius = 5.0f;
    [self loadBroadcastingToBar];
   
    commentTextField = [[UITextView alloc] initWithFrame:CGRectMake(10, 100, 300, 50)];
    [commentTextField becomeFirstResponder];
  //  commentTextField.placeholder = @"Add a comment (Optional)";
    [self.view addSubview:commentTextField];
    
}
-(void)viewWillAppear:(BOOL)animated {
      [self.navigationController.navigationItem setBackBarButtonItem:UIBarButtonItemStylePlain];
     [self.navigationController.view setFrame:CGRectMake(10, 30, 300,[[UIScreen mainScreen] bounds].size.height - 270)];
}
-(void)loadBroadcastingToBar{
    if (self.broadcastingToQueryInProgress) {
        return;
    }
    self.broadcastingToQueryInProgress = YES;
    //[SP] This should be cached
    PFQuery *query = [PFQuery queryWithClassName:kSPActivityClassKey];
    [query whereKey:kSPActivityFromUserKey equalTo:[PFUser currentUser]];
    [query whereKey:kSPActivityTypeKey equalTo:kSPActivityTypeFollow];
    [query includeKey:kSPActivityToUserKey];
    
     NSMutableArray *currentBroadcastees = [[NSMutableArray alloc] init];
    
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        // While normally there should only be one follow activity returned, we can't guarantee that.
        if (error) {
            NSLog(@"Error Loading Broadcasting To");
            return;
        }
        for (PFObject *broadcastees in objects) {
            [currentBroadcastees addObject:[broadcastees objectForKey:@"toUser"]];
        }
        
       
       
        NSInteger i;
        NSInteger numOfPics = numLikePics > currentBroadcastees.count ? currentBroadcastees.count : numLikePics;
        
        for (i = 0; i < numOfPics; i++) {
            SPProfileImageView *profilePic = [[SPProfileImageView alloc] init];
            [profilePic setFrame:CGRectMake(likeProfileXBase + i * (likeProfileXSpace + likeProfileDim), likeProfileY, likeProfileDim, likeProfileDim)];
         //   [profilePic.profileButton addTarget:self action:@selector(didTapLikerButtonAction:) forControlEvents:UIControlEventTouchUpInside];
            profilePic.profileButton.tag = i;
            [profilePic setFile:[[currentBroadcastees objectAtIndex:i] objectForKey:kSPUserProfilePicSmallKey]];
            [self.view addSubview:profilePic];
            [currentBroadcastees addObject:profilePic];
        }
    
    }];
}


-(id)initWithPlace:(NSDictionary *)placeObject
{
    self = [super init];
    if (self != nil)
    {
        place = placeObject;
    }
    
    return self;
}


-(void)doCheckin{
    
    // create a photo object
    PFObject *checkIn = [PFObject objectWithClassName:kSPCheckInClassKey];
    
   [checkIn setObject:[place objectForKey:@"place_id"] forKey:kSPCheckInPlaceKey];
   [checkIn setObject:[place objectForKey:@"name"] forKey:kSPCheckInPlaceNameKey];
   [checkIn setObject:[PFUser currentUser] forKey:kSPCheckInUserKey];
    [checkIn setObject:self.commentTextField.text forKey:kSPCheckInCommentsKey];
    
    
    // photos are public, but may only be modified by the user who uploaded them
    PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [photoACL setPublicReadAccess:YES];
    checkIn.ACL = photoACL;
    /*
    [photo setObject:self.photoFile forKey:kPAPPhotoPictureKey];
    [photo setObject:self.thumbnailFile forKey:kPAPPhotoThumbnailKey];
    
    // photos are public, but may only be modified by the user who uploaded them
    PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [photoACL setPublicReadAccess:YES];
    photo.ACL = photoACL;
    */
    
    [checkIn saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
      
            NSLog(@"yes");
            // Dismiss this screen
            [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
        }
        
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't Complete CheckIn" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
            [alert show];
            
        }

    }];
    
 
    
}
@end
