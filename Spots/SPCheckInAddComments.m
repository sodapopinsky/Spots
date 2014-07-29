//
//  SPCheckInAddComments.m
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckInAddComments.h"
#import "SPEditPhotoViewController.h"

@interface SPCheckInAddComments ()
@property (nonatomic, retain) NSDictionary* place;
@property (nonatomic, strong) UITextView *comments;
@end

@implementation SPCheckInAddComments
@synthesize place, map, comments, addPhoto;

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
     [map setShowsUserLocation:YES];
 
    NSDictionary *geometry = [place objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    
    CLLocationDegrees latitude = [[location objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitude = [[location objectForKey:@"lng"] doubleValue];
    

    MKCoordinateRegion region;
    
    CLLocationCoordinate2D placeCoord;
    // Set the lat and long.
    placeCoord.latitude=latitude;
    placeCoord.longitude=longitude;
    region = MKCoordinateRegionMakeWithDistance(placeCoord,1000,1000);
    
    [map setRegion:region animated:YES];
    

  

    UIView *addPhotoContainer = [[UIView alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 90, 10, 80, 80)];
    [addPhotoContainer setBackgroundColor:[UIColor blackColor]];
    [addPhotoContainer setAlpha:0.35f];
    addPhotoContainer.layer.cornerRadius = addPhotoContainer.frame.size.width / 2;
   // [addPhoto addTarget:self action:@selector(shouldStartCameraController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addPhotoContainer];
    
    addPhoto = [UIButton buttonWithType:UIButtonTypeCustom];
    [addPhoto setFrame:CGRectMake(addPhotoContainer.frame.origin.x + 5, addPhotoContainer.frame.origin.y + 5, addPhotoContainer.frame.size.width - 10, addPhotoContainer.frame.size.width - 10)];
    [addPhoto setBackgroundColor:[UIColor clearColor]];
    addPhoto.imageView.layer.masksToBounds = YES;
    addPhoto.imageView.layer.cornerRadius = addPhoto.frame.size.width / 2;
    [addPhoto setImage:[UIImage imageNamed:@"AvatarPlaceholder"] forState:UIControlStateNormal];
    
    [addPhoto addTarget:self action:@selector(shouldStartCameraController) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:addPhoto];
    

   
    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 95,320, 40)];
    [buttonView setBackgroundColor:[UIColor whiteColor]];
    [buttonView setAlpha:0.9f];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    [lbl1 setText:@"Visible to 7"];
    [lbl1 setFont:[UIFont systemFontOfSize:16.0f]];
    [lbl1 setAlpha:0.8f];
    [buttonView addSubview:lbl1];

    [self.view addSubview:buttonView];
    
    UIImageView *goCustom = [[UIImageView alloc] initWithFrame:CGRectMake(295, 5, 29*.5,.5 * 57)];
    [goCustom setImage:[UIImage imageNamed:@"RightArrow"]];
    [buttonView addSubview:goCustom];
  
   
    
    comments = [[UITextView alloc] initWithFrame:CGRectMake(10, 145, 300, 75)];
    [comments setBackgroundColor:[UIColor clearColor]];
    [comments setFont:[UIFont systemFontOfSize:15.0f]];
   // comments.layer.borderColor = kSPColorDarkGray.CGColor;
//    comments.layer.cornerRadius = 3.0f;
    
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

    [self presentViewController:cameraUI animated:YES completion:nil];
    
    return YES;
}

#pragma mark - UIImagePickerDelegate

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    [self dismissViewControllerAnimated:NO completion:nil];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
    [addPhoto setImage:image forState:UIControlStateNormal];
 //   SPEditPhotoViewController *viewController = [[SPEditPhotoViewController alloc] initWithImage:image];
 //   [viewController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
    
  // [self.navigationController setModalTransitionStyle:UIModalTransitionStyleCrossDissolve];
  // [self.navigationController pushViewController:viewController animated:NO];
    
   // [self presentViewController:viewController animated:YES completion:nil];
}




@end
