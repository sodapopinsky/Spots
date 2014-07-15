//
//  SPConstants.h
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - NSUserDefaults
extern NSString *const kSPUserDefaultsCacheFacebookFriendsKey;


#pragma mark - PFObject User Class
// Field keys
extern NSString *const kSPUserDisplayNameKey;
extern NSString *const kSPUserFacebookIDKey;
extern NSString *const kSPUserPhotoIDKey;
extern NSString *const kSPUserProfilePicSmallKey;
extern NSString *const kSPUserProfilePicMediumKey;
extern NSString *const kSPUserFacebookFriendsKey;
extern NSString *const kSPUserAlreadyAutoFollowedFacebookFriendsKey;
extern NSString *const kSPUserPrivateChannelKey;


#pragma mark - Cached User Attributes
// keys
extern NSString *const kSPUserAttributesPhotoCountKey;
extern NSString *const kSPUserAttributesIsFollowedByCurrentUserKey;

#pragma mark - PFObject Photo Class
// Class key
extern NSString *const kSPPhotoClassKey;

// Field keys
extern NSString *const kSPPhotoPictureKey;
extern NSString *const kSPPhotoThumbnailKey;
extern NSString *const kSPPhotoUserKey;

#pragma mark - Cached Photo Attributes
// keys
NSString *const kSPPhotoAttributesIsLikedByCurrentUserKey = @"isLikedByCurrentUser";
NSString *const kSPPhotoAttributesLikeCountKey            = @"likeCount";
NSString *const kSPPhotoAttributesLikersKey               = @"likers";
NSString *const kSPPhotoAttributesCommentCountKey         = @"commentCount";
NSString *const kSPPhotoAttributesCommentersKey           = @"commenters";


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

#pragma mark - Cached User Attributes
// keys
extern NSString *const kSPUserAttributesIsFollowedByCurrentUserKey;

