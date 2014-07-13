//
//  SPConstants.h
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <Foundation/Foundation.h>


#pragma mark - PFObject User Class
// Field keys
extern NSString *const kSPUserDisplayNameKey;
extern NSString *const kSPUserFacebookIDKey;
extern NSString *const kSPUserPhotoIDKey;
extern NSString *const kSPUserProfilePicSmallKey;
extern NSString *const kSPUserProfilePicMediumKey;
extern NSString *const kSPUserAlreadyAutoFollowedFacebookFriendsKey;
extern NSString *const kSPUserPrivateChannelKey;


#pragma mark - PFObject Photo Class
// Class key
extern NSString *const kSPPhotoClassKey;


#pragma mark - PFObject Activity Class
// Class key
extern NSString *const kSPActivityClassKey;

// Field keys
extern NSString *const kSPActivityTypeKey;
extern NSString *const kSPActivityFromUserKey;
extern NSString *const kSPActivityToUserKey;
extern NSString *const kSPActivityContentKey;
extern NSString *const kSPActivityPhotoKey;

// Type values
extern NSString *const kSPActivityTypeLike;
extern NSString *const kSPActivityTypeFollow;
extern NSString *const kSPActivityTypeComment;
extern NSString *const kSPActivityTypeJoined;

