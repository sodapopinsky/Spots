//
//  SPCheckinCommentsViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/17/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckinCommentsViewController.h"

@interface SPCheckinCommentsViewController ()
@property (nonatomic, retain) NSDictionary* place;
@end

@implementation SPCheckinCommentsViewController
@synthesize place;
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
  
  self.title = [place objectForKey:@"name"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"do checkin" style:UIBarButtonItemStyleBordered target:self action:@selector(doCheckin)];

   
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(id)initWithPlace:(NSDictionary *)placeObject
{
    self = [super init];
    if (self != nil)
    {
        NSLog(@"%@",placeObject);
        place = placeObject;
    }
    
    return self;
}

-(void)doCheckin{
    
    // create a photo object
    PFObject *checkIn = [PFObject objectWithClassName:kSPCheckInClassKey];
    
    [checkIn setObject:[place objectForKey:@"place_id"] forKey:kSPCheckInPlaceKey];
   [checkIn setObject:[PFUser currentUser] forKey:kSPCheckInUserKey];
    
    
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
