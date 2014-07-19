//
//  SPConstants.h
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <Foundation/Foundation.h>

extern NSString *const kGOOGLE_API_KEY;

#pragma mark - NSUserDefaults
extern NSString *const kSPUserDefaultsCacheFacebookFriendsKey;
extern NSString *const kSPUserDefaultsCacheBroadcastingToKey;

#pragma mark - User Info Keys
extern NSString *const SPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey;
extern NSString *const kSPEditPhotoViewControllerUserInfoCommentKey;

#pragma mark - NSNotification
extern NSString *const SPAppDelegateApplicationDidReceiveRemoteNotification;
extern NSString *const SPUtilityUserFollowingChangedNotification;
extern NSString *const SPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification;
extern NSString *const SPUtilityDidFinishProcessingProfilePictureNotification;
extern NSString *const SPTabBarControllerDidFinishEditingPhotoNotification;
extern NSString *const SPTabBarControllerDidFinishImageFileUploadNotification;
extern NSString *const SPPhotoDetailsViewControllerUserDeletedPhotoNotification;
extern NSString *const SPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification;
extern NSString *const SPPhotoDetailsViewControllerUserCommentedOnPhotoNotification;

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

#pragma mark - PFObject Checkin Class
// Class key
extern NSString *const kSPCheckInClassKey;

//Field Key
extern NSString *const kSPCheckInPlaceKey;
extern NSString *const kSPCheckInPlaceNameKey;
extern NSString *const kSPCheckInUserKey;
#pragma mark - PFObject Photo Class
// Class key
extern NSString *const kSPPhotoClassKey;

// Field keys
extern NSString *const kSPPhotoPictureKey;
extern NSString *const kSPPhotoThumbnailKey;
extern NSString *const kSPPhotoUserKey;


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


#pragma mark - Cached Photo Attributes
// keys
extern NSString *const kSPPhotoAttributesIsLikedByCurrentUserKey;
extern NSString *const kSPPhotoAttributesLikeCountKey;
extern NSString *const kSPPhotoAttributesLikersKey;
extern NSString *const kSPPhotoAttributesCommentCountKey;
extern NSString *const kSPPhotoAttributesCommentersKey;

