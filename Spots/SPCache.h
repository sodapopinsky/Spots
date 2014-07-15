//
//  SPCache.h
//  Spots
//
//  Created by Nicholas Spitale on 7/13/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPCache : NSObject

+ (id)sharedCache;

- (void)clear;

//May not be using
- (void)setAttributesForPhoto:(PFObject *)photo likers:(NSArray *)likers commenters:(NSArray *)commenters likedByCurrentUser:(BOOL)likedByCurrentUser;
- (NSDictionary *)attributesForPhoto:(PFObject *)photo;

- (void)setFacebookFriends:(NSArray *)friends;
- (NSArray *)facebookFriends;
- (void)setFollowStatus:(BOOL)following user:(PFUser *)user;
- (void)setPhotoCount:(NSNumber *)count user:(PFUser *)user;
- (NSNumber *)photoCountForUser:(PFUser *)user;
- (BOOL)followStatusForUser:(PFUser *)user;
- (NSDictionary *)attributesForUser:(PFUser *)user;
@end
