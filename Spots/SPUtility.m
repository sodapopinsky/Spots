//
//  SPUtility.m
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPUtility.h"
#import "UIImage+ResizeAdditions.h"

@implementation SPUtility

+ (BOOL)userHasValidFacebookData:(PFUser *)user {
    NSString *facebookId = [user objectForKey:kSPUserFacebookIDKey];
    return (facebookId && facebookId.length > 0);
}

+ (void)addBottomDropShadowToNavigationBarForNavigationController:(UINavigationController *)navigationController {
    UIView *gradientView = [[UIView alloc] initWithFrame:CGRectMake(0.0f, navigationController.navigationBar.frame.size.height, navigationController.navigationBar.frame.size.width, 3.0f)];
    [gradientView setBackgroundColor:[UIColor clearColor]];
    
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = gradientView.bounds;
    gradient.colors = [NSArray arrayWithObjects:(id)[[UIColor blackColor] CGColor], (id)[[UIColor clearColor] CGColor], nil];
    [gradientView.layer insertSublayer:gradient atIndex:0];
    navigationController.navigationBar.clipsToBounds = NO;
    [navigationController.navigationBar addSubview:gradientView];
}

#pragma mark User Following

+ (void)followUserInBackground:(PFUser *)user block:(void (^)(BOOL succeeded, NSError *error))completionBlock {
    if ([[user objectId] isEqualToString:[[PFUser currentUser] objectId]]) {
        return;
    }
    
    PFObject *followActivity = [PFObject objectWithClassName:kSPActivityClassKey];
    [followActivity setObject:[PFUser currentUser] forKey:kSPActivityFromUserKey];
    [followActivity setObject:user forKey:kSPActivityToUserKey];
    [followActivity setObject:kSPActivityTypeFollow forKey:kSPActivityTypeKey];
    
    PFACL *followACL = [PFACL ACLWithUser:[PFUser currentUser]];
    [followACL setPublicReadAccess:YES];
    followActivity.ACL = followACL;
    
    [followActivity saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (completionBlock) {
            completionBlock(succeeded, error);
        }
    }];
    [[SPCache sharedCache] setFollowStatus:YES user:user];
}


#pragma mark Facebook

+ (void)processFacebookProfilePictureData:(NSData *)newProfilePictureData {
    if (newProfilePictureData.length == 0) {
        NSLog(@"Profile picture did not download successfully.");
        return;
    }
    
    // The user's Facebook profile picture is cached to disk. Check if the cached profile picture data matches the incoming profile picture. If it does, avoid uploading this data to Parse.
    
    NSURL *cachesDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSCachesDirectory inDomains:NSUserDomainMask] lastObject]; // iOS Caches directory
    
    NSURL *profilePictureCacheURL = [cachesDirectoryURL URLByAppendingPathComponent:@"FacebookProfilePicture.jpg"];
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:[profilePictureCacheURL path]]) {
        // We have a cached Facebook profile picture
        
        NSData *oldProfilePictureData = [NSData dataWithContentsOfFile:[profilePictureCacheURL path]];
        
        if ([oldProfilePictureData isEqualToData:newProfilePictureData]) {
            NSLog(@"Cached profile picture matches incoming profile picture. Will not update.");
            return;
        }
    }
    
    BOOL cachedToDisk = [[NSFileManager defaultManager] createFileAtPath:[profilePictureCacheURL path] contents:newProfilePictureData attributes:nil];
    NSLog(@"Wrote profile picture to disk cache: %d", cachedToDisk);
    
    UIImage *image = [UIImage imageWithData:newProfilePictureData];
    
    UIImage *mediumImage = [image thumbnailImage:280 transparentBorder:0 cornerRadius:0 interpolationQuality:kCGInterpolationHigh];
    
    UIImage *smallRoundedImage = [image thumbnailImage:64 transparentBorder:0 cornerRadius:9 interpolationQuality:kCGInterpolationLow];
    
    NSData *mediumImageData = UIImageJPEGRepresentation(mediumImage, 0.5); // using JPEG for larger pictures
    NSData *smallRoundedImageData = UIImagePNGRepresentation(smallRoundedImage);
    
    if (mediumImageData.length > 0) {
        NSLog(@"Uploading Medium Profile Picture");
        PFFile *fileMediumImage = [PFFile fileWithData:mediumImageData];
        [fileMediumImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Uploaded Medium Profile Picture");
                [[PFUser currentUser] setObject:fileMediumImage forKey:kSPUserProfilePicMediumKey];
                [[PFUser currentUser] saveEventually];
            }
        }];
    }
    
    if (smallRoundedImageData.length > 0) {
        NSLog(@"Uploading Profile Picture Thumbnail");
        PFFile *fileSmallRoundedImage = [PFFile fileWithData:smallRoundedImageData];
        [fileSmallRoundedImage saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
            if (!error) {
                NSLog(@"Uploaded Profile Picture Thumbnail");
                [[PFUser currentUser] setObject:fileSmallRoundedImage forKey:kSPUserProfilePicSmallKey];
                [[PFUser currentUser] saveEventually];
            }
        }];
    }
}



@end
