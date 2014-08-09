//
//  SPCheckInAddComments.m
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//


#import "SPCheckInAddComments.h"
#import "SPSelectVisibility.h"
#import "SPProfileImageView.h"

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


-(void)viewWillAppear:(BOOL)animated{
    
    self.navigationController.navigationBarHidden = NO;
  
    [comments becomeFirstResponder];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
 //   self.navigationController.navigationBar.topItem.title = @"";
  //  [[UIApplication sharedApplication] setStatusBarHidden:YES
            //                                withAnimation:UIStatusBarAnimationFade];
    
// self.navigationController.navigationBarHidden = NO;

    [self setTitle:[place objectForKey:@"name"]];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 75)];
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
   
    placeCoord.latitude=latitude;
    placeCoord.longitude=longitude;

   
    region = MKCoordinateRegionMakeWithDistance(placeCoord,600,600);
    
    [map setRegion:region animated:YES];
    
 
  



    

    

   
    SPProfileImageView *userAvatar = [[SPProfileImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 50, 100, 40, 40)];
    PFFile *imageFile = [[PFUser currentUser] objectForKey:kSPUserProfilePicSmallKey];
    [userAvatar setFile:imageFile];
    [self.view addSubview:userAvatar];

    
    
    comments = [[UITextView alloc] initWithFrame:CGRectMake(10, 90, 215, 65)];
    [comments setBackgroundColor:[UIColor clearColor]];
    [comments setFont:[UIFont systemFontOfSize:15.0f]];
    [comments setText:@"What's Up?"];
    [comments setTextColor:kSPColorDarkGray];
    
    [comments becomeFirstResponder];
    
    [self.view addSubview:comments];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(5,156, self.view.bounds.size.width - 10, 1)];
    lineView.backgroundColor = kSPColorDarkGray;
    [self.view addSubview:lineView];
    
    UIButton *btnDoCheckIn = [[UIButton alloc] initWithFrame:CGRectMake(190, 163, 120, 30)];
    [btnDoCheckIn setBackgroundColor:kSPColorBlue];
    [btnDoCheckIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDoCheckIn setTitle:@"Next" forState:UIControlStateNormal];
    btnDoCheckIn.layer.cornerRadius = 5.0f;
    [btnDoCheckIn addTarget:self action:@selector(goSelectVisibility) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDoCheckIn];
    
    
    
    addPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [addPhoto setFrame:CGRectMake(5, 155, 50*1.5, 29*1.5)];
    [addPhoto setBackgroundColor:[UIColor clearColor]];
    [addPhoto setContentMode:UIViewContentModeScaleAspectFill];
    [addPhoto setImage:[UIImage imageNamed:@"CameraDark"] forState:UIControlStateNormal];
    
    [addPhoto addTarget:self action:@selector(shouldStartCameraController) forControlEvents:UIControlEventTouchUpInside];
    
     [self.view addSubview:addPhoto];
    
    
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
