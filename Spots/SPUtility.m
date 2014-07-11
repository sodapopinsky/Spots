//
//  SPUtility.m
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPUtility.h"

@implementation SPUtility

+ (BOOL)userHasValidFacebookData:(PFUser *)user {
    NSString *facebookId = [user objectForKey:kSPUserFacebookIDKey];
    return (facebookId && facebookId.length > 0);
}

@end
