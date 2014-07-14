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


- (void)setFacebookFriends:(NSArray *)friends;
- (NSArray *)facebookFriends;
- (void)setFollowStatus:(BOOL)following user:(PFUser *)user;

- (NSDictionary *)attributesForUser:(PFUser *)user;
@end
