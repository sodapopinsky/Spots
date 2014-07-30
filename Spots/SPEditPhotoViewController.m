//
//  SPEditPhotoViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/16/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPEditPhotoViewController.h"
#import "UIImage+ResizeAdditions.h"

@interface SPEditPhotoViewController ()

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) PFFile *photoFile;
@property (nonatomic, strong) PFFile *thumbnailFile;
@property (nonatomic, strong) UISwitch *isSpotshot;
@property (nonatomic, assign) UIBackgroundTaskIdentifier fileUploadBackgroundTaskId;
@property (nonatomic, assign) UIBackgroundTaskIdentifier photoPostBackgroundTaskId;
@end

@implementation SPEditPhotoViewController

@synthesize image;
@synthesize photoFile;
@synthesize thumbnailFile;
@synthesize fileUploadBackgroundTaskId;
@synthesize photoPostBackgroundTaskId;
@synthesize isSpotshot;
#pragma mark - NSObject

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (id)initWithImage:(UIImage *)aImage {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        if (!aImage) {
            return nil;
        }
        
        self.image = aImage;
        self.fileUploadBackgroundTaskId = UIBackgroundTaskInvalid;
        self.photoPostBackgroundTaskId = UIBackgroundTaskInvalid;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    NSLog(@"Memory warning on Edit");
}


#pragma mark - UIViewController

- (void)loadView {


    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 42.0f, 280.0f, 280.0f)];
    [photoImageView setBackgroundColor:[UIColor blackColor]];
    [photoImageView setImage:self.image];
    [photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    
      self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame]];
    
    
    CALayer *layer = photoImageView.layer;
    layer.masksToBounds = NO;
    layer.shadowRadius = 3.0f;
    layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    layer.shadowOpacity = 0.5f;
    layer.shouldRasterize = YES;
    
    [self.view addSubview:photoImageView];
    
}


/* Inform delegate that a user image or name was tapped */
- (void)testFunction{

    if (self.delegate && [self.delegate respondsToSelector:@selector(testFunction)]) {
        [self.delegate testFunction];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:kSPColorLightGray];
    self.navigationController.navigationBarHidden = YES;
    
    isSpotshot = [[UISwitch alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 80, 320, 20, 20)];
    [self.view addSubview:isSpotshot];
    
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(20, 340, 250, 20)];
    [lbl setText:@"Make this a Spotshot"];
    [self.view addSubview:lbl];
    
    /*
    UILabel *sub = [[UILabel alloc] initWithFrame:CGRectMake(20, 370, 250, 20)];
    [sub setText:@"Spotshots let everyone see what's going on"];
    [sub setFont:[UIFont systemFontOfSize:13.0f]];
    [sub setTextColor:kSPColorLightGray];
    [self.view addSubview:sub];
    */
    
    UIButton *btnDelete = [[UIButton alloc] initWithFrame:CGRectMake(20, 370,280, 30)];
    [btnDelete setBackgroundColor:kSPColorDarkGray];
    [btnDelete setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDelete setTitle:@"Delete" forState:UIControlStateNormal];
    btnDelete.layer.cornerRadius = 5.0f;
    [btnDelete addTarget:self action:@selector(deletePhoto) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDelete];
    
    
    UIButton *btnUse = [[UIButton alloc] initWithFrame:CGRectMake(20, 410,280, 30)];
    [btnUse setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:24.0f/255.0f alpha:1.0f]];
    
    
    [btnUse setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnUse setTitle:@"Use Photo" forState:UIControlStateNormal];
    btnUse.layer.cornerRadius = 5.0f;
    [btnUse addTarget:self action:@selector(testFunction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnUse];
    
    
    
    /*
    UIImageView *photoImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20.0f, 42.0f, 280.0f, 280.0f)];
    [photoImageView setBackgroundColor:[UIColor blackColor]];
    [photoImageView setImage:self.image];
    [photoImageView setContentMode:UIViewContentModeScaleAspectFit];
    
    CALayer *layer = photoImageView.layer;
    layer.masksToBounds = NO;
    layer.shadowRadius = 3.0f;
    layer.shadowOffset = CGSizeMake(0.0f, 2.0f);
    layer.shadowOpacity = 0.5f;
    layer.shouldRasterize = YES;
    
    [self.view addSubview:photoImageView];
    
    [self.navigationItem setHidesBackButton:YES];
    [self.view setBackgroundColor:kSPColorLightGray];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
*/
    /*
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LogoNavigationBar.png"]];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Publish" style:UIBarButtonItemStyleDone target:self action:@selector(doneButtonAction:)];
    */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
  //  [self shouldUploadImage:self.image];
}

#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self doneButtonAction:textField];
    [textField resignFirstResponder];
    return YES;
}


-(void)deletePhoto{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)usePhoto{
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - ()

- (BOOL)shouldUploadImage:(UIImage *)anImage {
    UIImage *resizedImage = [anImage resizedImageWithContentMode:UIViewContentModeScaleAspectFit bounds:CGSizeMake(560.0f, 560.0f) interpolationQuality:kCGInterpolationHigh];
    UIImage *thumbnailImage = [anImage thumbnailImage:86.0f transparentBorder:0.0f cornerRadius:10.0f interpolationQuality:kCGInterpolationDefault];
    
    // JPEG to decrease file size and enable faster uploads & downloads
    NSData *imageData = UIImageJPEGRepresentation(resizedImage, 0.8f);
    NSData *thumbnailImageData = UIImagePNGRepresentation(thumbnailImage);
    
    if (!imageData || !thumbnailImageData) {
        return NO;
    }
    
    self.photoFile = [PFFile fileWithData:imageData];
    self.thumbnailFile = [PFFile fileWithData:thumbnailImageData];
    
    // Request a background execution task to allow us to finish uploading the photo even if the app is backgrounded
    self.fileUploadBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
    }];
    
    [self.photoFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            [self.thumbnailFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
            }];
        } else {
            [[UIApplication sharedApplication] endBackgroundTask:self.fileUploadBackgroundTaskId];
        }
    }];
    
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)note {
    /*
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize scrollViewContentSize = self.scrollView.bounds.size;
    scrollViewContentSize.height += keyboardFrameEnd.size.height;
    [self.scrollView setContentSize:scrollViewContentSize];
    
    CGPoint scrollViewContentOffset = self.scrollView.contentOffset;
    // Align the bottom edge of the photo with the keyboard
    scrollViewContentOffset.y = scrollViewContentOffset.y + keyboardFrameEnd.size.height*3.0f - [UIScreen mainScreen].bounds.size.height;
    
    [self.scrollView setContentOffset:scrollViewContentOffset animated:YES];
     */
}

- (void)keyboardWillHide:(NSNotification *)note {
    /*
    CGRect keyboardFrameEnd = [[note.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGSize scrollViewContentSize = self.scrollView.bounds.size;
    scrollViewContentSize.height -= keyboardFrameEnd.size.height;
    [UIView animateWithDuration:0.200f animations:^{
        [self.scrollView setContentSize:scrollViewContentSize];
    }];
     */
}


- (void)doneButtonAction:(id)sender {
    
    /*
    NSDictionary *userInfo = [NSDictionary dictionary];
    NSString *trimmedComment = [self.commentTextField.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
    if (trimmedComment.length != 0) {
        userInfo = [NSDictionary dictionaryWithObjectsAndKeys:
                    trimmedComment,kSPEditPhotoViewControllerUserInfoCommentKey,
                    nil];
        
    }
    
    // Make sure there were no errors creating the image files
    if (!self.photoFile || !self.thumbnailFile) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't post your photo" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
        [alert show];
        return;
    }
    
    // both files have finished uploading
    
    // create a photo object
    PFObject *photo = [PFObject objectWithClassName:kSPPhotoClassKey];
    [photo setObject:[PFUser currentUser] forKey:kSPPhotoUserKey];
    [photo setObject:self.photoFile forKey:kSPPhotoPictureKey];
    [photo setObject:self.thumbnailFile forKey:kSPPhotoThumbnailKey];
    
    // photos are public, but may only be modified by the user who uploaded them
    PFACL *photoACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [photoACL setPublicReadAccess:YES];
    photo.ACL = photoACL;
    
    // Request a background execution task to allow us to finish uploading the photo even if the app is backgrounded
    self.photoPostBackgroundTaskId = [[UIApplication sharedApplication] beginBackgroundTaskWithExpirationHandler:^{
        [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
    }];
    
    // Save the Photo PFObject
    [photo saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            
            [[SPCache sharedCache] setAttributesForPhoto:photo likers:[NSArray array] commenters:[NSArray array] likedByCurrentUser:NO];
            
            // userInfo might contain any caption which might have been posted by the uploader
            if (userInfo) {
                NSString *commentText = [userInfo objectForKey:kSPEditPhotoViewControllerUserInfoCommentKey];
                
                if (commentText && commentText.length != 0) {
                    // create and save photo caption
                    PFObject *comment = [PFObject objectWithClassName:kSPActivityClassKey];
                    [comment setObject:kSPActivityTypeComment forKey:kSPActivityTypeKey];
                    [comment setObject:photo forKey:kSPActivityPhotoKey];
                    [comment setObject:[PFUser currentUser] forKey:kSPActivityFromUserKey];
                    [comment setObject:[PFUser currentUser] forKey:kSPActivityToUserKey];
                    [comment setObject:commentText forKey:kSPActivityContentKey];
                    
                    PFACL *ACL = [PFACL ACLWithUser:[PFUser currentUser]];
                    [ACL setPublicReadAccess:YES];
                    comment.ACL = ACL;
                    
                    [comment saveEventually];
                    [[SPCache sharedCache] incrementCommentCountForPhoto:photo];
                }
            }
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SPTabBarControllerDidFinishEditingPhotoNotification object:photo];
        } else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Couldn't post your photo" message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
            [alert show];
        }
        [[UIApplication sharedApplication] endBackgroundTask:self.photoPostBackgroundTaskId];
    }];
    
    // Dismiss this screen
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
     */
}

- (void)cancelButtonAction:(id)sender {
    [self.parentViewController dismissViewControllerAnimated:YES completion:nil];
}

@end
