//
//  SPConstants.m
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPConstants.h"

NSString *const kGOOGLE_API_KEY = @"AIzaSyCvAt6OnrRukTDmZLZ_oMLhgGbt0OrEgrI";

#pragma mark - NSUserDefaults
NSString *const kSPUserDefaultsCacheFacebookFriendsKey                     = @"com.parse.Anypic.userDefaults.cache.facebookFriends"; /// *durr
NSString *const kSPUserDefaultsCacheBroadcastingToKey                      = @"com.Spots.userDefaults.cache.broadcastingTo";


#pragma mark - User Info Keys
NSString *const SPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotificationUserInfoLikedKey = @"liked";
NSString *const kSPEditPhotoViewControllerUserInfoCommentKey = @"comment";

#pragma mark - NSNotification

NSString *const SPAppDelegateApplicationDidReceiveRemoteNotification           = @"com.parse.Anypic.appDelegate.applicationDidReceiveRemoteNotification";
NSString *const SPUtilityUserFollowingChangedNotification                      = @"com.parse.Anypic.utility.userFollowingChanged";
NSString *const SPUtilityUserLikedUnlikedPhotoCallbackFinishedNotification     = @"com.parse.Anypic.utility.userLikedUnlikedPhotoCallbackFinished";
NSString *const SPUtilityDidFinishProcessingProfilePictureNotification         = @"com.parse.Anypic.utility.didFinishProcessingProfilePictureNotification";
NSString *const SPTabBarControllerDidFinishEditingPhotoNotification            = @"com.parse.Anypic.tabBarController.didFinishEditingPhoto";
NSString *const SPTabBarControllerDidFinishImageFileUploadNotification         = @"com.parse.Anypic.tabBarController.didFinishImageFileUploadNotification";
NSString *const SPPhotoDetailsViewControllerUserDeletedPhotoNotification       = @"com.parse.Anypic.photoDetailsViewController.userDeletedPhoto";
NSString *const SPPhotoDetailsViewControllerUserLikedUnlikedPhotoNotification  = @"com.parse.Anypic.photoDetailsViewController.userLikedUnlikedPhotoInDetailsViewNotification";
NSString *const SPPhotoDetailsViewControllerUserCommentedOnPhotoNotification   = @"com.parse.Anypic.photoDetailsViewController.userCommentedOnPhotoInDetailsViewNotification";


#pragma mark - User Class
// Field keys
NSString *const kSPUserDisplayNameKey                          = @"displayName";
NSString *const kSPUserFacebookIDKey                           = @"facebookId";
NSString *const kSPUserPhotoIDKey                              = @"photoId";
NSString *const kSPUserProfilePicSmallKey                      = @"profilePictureSmall";
NSString *const kSPUserProfilePicMediumKey                     = @"profilePictureMedium";
NSString *const kSPUserFacebookFriendsKey                      = @"facebookFriends";
NSString *const kSPUserAlreadyAutoFollowedFacebookFriendsKey   = @"userAlreadyAutoFollowedFacebookFriends";
NSString *const kSPUserPrivateChannelKey                       = @"channel";

#pragma mark - Checkin Class
// Class key
NSString *const kSPCheckInClassKey = @"CheckIn";

//Field keys
NSString *const kSPCheckInPlaceKey = @"googlePlaceID";
NSString *const kSPCheckInUserKey = @"user";
NSString *const kSPCheckInPlaceNameKey = @"placeName";

#pragma mark - Photo Class
// Class key
NSString *const kSPPhotoClassKey = @"Photo";

// Field keys
NSString *const kSPPhotoPictureKey         = @"image";
NSString *const kSPPhotoThumbnailKey       = @"thumbnail";
NSString *const kSPPhotoUserKey            = @"user";


#pragma mark - Activity Class
// Class key
NSString *const kSPActivityClassKey = @"Activity";

// Field keys
NSString *const kSPActivityTypeKey        = @"type";
NSString *const kSPActivityFromUserKey    = @"fromUser";
NSString *const kSPActivityToUserKey      = @"toUser";
NSString *const kSPActivityContentKey     = @"content";
NSString *const kSPActivityPhotoKey       = @"photo";

// Type values
NSString *const kSPActivityTypeLike       = @"like";
NSString *const kSPActivityTypeFollow     = @"follow";
NSString *const kSPActivityTypeComment    = @"comment";
NSString *const kSPActivityTypeJoined     = @"joined";

#pragma mark - Cached User Attributes
// keys
NSString *const kSPUserAttributesIsFollowedByCurrentUserKey    = @"isFollowedByCurrentUser";

#pragma mark - Cached Photo Attributes
// keys
NSString *const kSPPhotoAttributesIsLikedByCurrentUserKey = @"isLikedByCurrentUser";
NSString *const kSPPhotoAttributesLikeCountKey            = @"likeCount";
NSString *const kSPPhotoAttributesLikersKey               = @"likers";
NSString *const kSPPhotoAttributesCommentCountKey         = @"commentCount";
NSString *const kSPPhotoAttributesCommentersKey           = @"commenters";





