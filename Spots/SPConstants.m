//
//  SPConstants.m
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPConstants.h"

#pragma mark - NSUserDefaults
NSString *const kSPUserDefaultsCacheFacebookFriendsKey                     = @"com.parse.Anypic.userDefaults.cache.facebookFriends"; /// *durr

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


