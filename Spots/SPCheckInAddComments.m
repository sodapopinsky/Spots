//
//  SPCheckInAddComments.m
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//


#import "SPCheckInAddComments.h"
#import "SPSelectVisibility.h"


@interface SPCheckInAddComments ()
@property (nonatomic, retain) NSDictionary* place;
@property (nonatomic, strong) UITextView *comments;
@property (nonatomic) BOOL imageIsSet, isSpotshot;
@end

@implementation SPCheckInAddComments
@synthesize place, map, comments, addPhoto, editPhotoViewController, imageIsSet, isSpotshot;

-(id)initWithPlace:(NSDictionary *)placeObject
{
    self = [super init];
    if (self != nil)
    {
        place = placeObject;
      
    }
    return self;
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = YES;
    [comments becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[UIApplication sharedApplication] setStatusBarHidden:YES
                                            withAnimation:UIStatusBarAnimationFade];
    
 self.navigationController.navigationBarHidden = YES;

    [self setTitle:[place objectForKey:@"name"]];
    [self.view setBackgroundColor:kSPColorLightGray];
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 135)];
    map.delegate = self;
    [self.view addSubview:map];
     [map setShowsUserLocation:NO];
    [map setUserInteractionEnabled:YES];
    
    imageIsSet = NO;
    
    NSDictionary *geometry = [place objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    
    CLLocationDegrees latitude = [[location objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitude = [[location objectForKey:@"lng"] doubleValue];
    

    MKCoordinateRegion region;
    
    CLLocationCoordinate2D placeCoord;
    // Set the lat and long.
    
    placeCoord.latitude=latitude;
    placeCoord.longitude=longitude;

    MapPoint *placeObject = [[MapPoint alloc] initWithName:@"" address:@"" coordinate:placeCoord];
    [map addAnnotation:placeObject];
   
    placeCoord.latitude=latitude - .00065;
    placeCoord.longitude=longitude + .005;

   
    region = MKCoordinateRegionMakeWithDistance(placeCoord,600,600);
    
    [map setRegion:region animated:YES];
    
 
  

    UIView *addPhotoContainer = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 95,0, 95, 95)];
    [addPhotoContainer setBackgroundColor:[UIColor blackColor]];
    [addPhotoContainer setAlpha:0.65f];

   // [addPhoto addTarget:self action:@selector(shouldStartCameraController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPhotoContainer];
    
    addPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [addPhoto setFrame:CGRectMake(addPhotoContainer.frame.origin.x + 5, addPhotoContainer.frame.origin.y + 5, addPhotoContainer.frame.size.width - 10, addPhotoContainer.frame.size.width - 10)];
    [addPhoto setBackgroundColor:[UIColor clearColor]];

    [addPhoto setImage:[UIImage imageNamed:@"CameraAdd"] forState:UIControlStateNormal];
    
    [addPhoto addTarget:self action:@selector(shouldStartCameraController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addPhoto];
    

   
    
    UIButton *buttonView = [[UIButton alloc] initWithFrame:CGRectMake(0, 95,320, 45)];
    [buttonView setBackgroundColor:[UIColor whiteColor]];
    [buttonView setAlpha:0.9f];
     [buttonView addTarget:self action:@selector(goSelectVisibility) forControlEvents:UIControlEventTouchUpInside];
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 13, 200, 20)];
    [lbl1 setText:@"Visible to 7"];
    [lbl1 setFont:[UIFont systemFontOfSize:16.0f]];
    [lbl1 setAlpha:0.8f];
    [buttonView addSubview:lbl1];

    [self.view addSubview:buttonView];
    
    UIButton *selectVisibility = [UIButton buttonWithType:UIButtonTypeCustom];
    [selectVisibility setImage:[UIImage imageNamed:@"RightArrow"] forState:UIControlStateNormal];
    [selectVisibility addTarget:self action:@selector(goSelectVisibility) forControlEvents:UIControlEventTouchUpInside];
     [selectVisibility setFrame:CGRectMake(295, 7, 29*.5,.5 * 57)];

    [buttonView addSubview:selectVisibility];

    
    UIView *userAvatarContainer = [[UIView alloc] initWithFrame:CGRectMake(10,150, 60, 60)];
    [userAvatarContainer setBackgroundColor:[UIColor blackColor]];
    [userAvatarContainer setAlpha:0.35f];
    userAvatarContainer.layer.cornerRadius = userAvatarContainer.frame.size.width / 2;

    [self.view addSubview:userAvatarContainer];
    
    UIImageView *userAvatar = [[UIImageView alloc] initWithFrame:CGRectMake(userAvatarContainer.frame.origin.x + 5, userAvatarContainer.frame.origin.y + 5, userAvatarContainer.frame.size.width - 10, userAvatarContainer.frame.size.width - 10)];
    [userAvatar setBackgroundColor:[UIColor clearColor]];
    userAvatar.layer.masksToBounds = YES;
    userAvatar.layer.cornerRadius = userAvatar.frame.size.width / 2;
    [userAvatar setImage:[UIImage imageNamed:@"AvatarPlaceholder"]];
    [self.view addSubview:userAvatar];
    
    
    comments = [[UITextView alloc] initWithFrame:CGRectMake(85, 145, 215, 75)];
    [comments setBackgroundColor:[UIColor clearColor]];
    [comments setFont:[UIFont systemFontOfSize:15.0f]];

    
   [comments becomeFirstResponder];
    
    [self.view addSubview:comments];
    UIButton *btnDoCheckIn = [[UIButton alloc] initWithFrame:CGRectMake(175, 228, 135, 30)];
    [btnDoCheckIn setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:24.0f/255.0f alpha:1.0f]];
    
    
    [btnDoCheckIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDoCheckIn setTitle:@"Check In" forState:UIControlStateNormal];
    btnDoCheckIn.layer.cornerRadius = 5.0f;
    [btnDoCheckIn addTarget:self action:@selector(doCheckin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDoCheckIn];
    
     UIButton *cancel = [[UIButton alloc] initWithFrame:CGRectMake(10, 228, 135, 30)];
    [cancel  setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [cancel setTitle:@"Cancel" forState:UIControlStateNormal];
    [cancel setBackgroundColor:kSPColorDarkGray];
    cancel.layer.cornerRadius = 5.0f;
    [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];
    
    
    
    editPhotoViewController  = [[SPEditPhotoViewController alloc] init];
    editPhotoViewController.delegate = self;
}

-(void)goSelectVisibility{
    SPSelectVisibility *controller = [[SPSelectVisibility alloc] init];
    [self.navigationController pushViewController:controller animated:YES];
}
-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)doCheckin{
    
}


- (BOOL)shouldStartCameraController {
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] == NO) {
        return NO;
    }
    
    UIImagePickerController *cameraUI = [[UIImagePickerController alloc] init];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]
        && [[UIImagePickerController availableMediaTypesForSourceType:
             UIImagePickerControllerSourceTypeCamera] containsObject:(NSString *)kUTTypeImage]) {
     
        cameraUI.mediaTypes = [NSArray arrayWithObject:(NSString *) kUTTypeImage];
        cameraUI.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceRear]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        } else if ([UIImagePickerController isCameraDeviceAvailable:UIImagePickerControllerCameraDeviceFront]) {
            cameraUI.cameraDevice = UIImagePickerControllerCameraDeviceFront;
        }
        
    } else {
        return NO;
    }
    
    cameraUI.allowsEditing = YES;
    cameraUI.showsCameraControls = YES;
    cameraUI.delegate = self;
    if(imageIsSet){
         [self.navigationController pushViewController:editPhotoViewController animated:YES];
    }
    else{
    [self presentViewController:cameraUI animated:YES completion:nil];
    }
    return YES;
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    editPhotoViewController.image = image;

   [self.navigationController pushViewController:editPhotoViewController animated:YES];
    

}


- (void)useImage:(UIImage *)image{
    
    
    if(image){
         imageIsSet = YES;
        [addPhoto setImage:image forState:UIControlStateNormal];
        
    }
    else{
        imageIsSet = NO;
        [addPhoto setImage:[UIImage imageNamed:@"CameraAdd"] forState:UIControlStateNormal];
    }
}

@end
