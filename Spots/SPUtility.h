//
//  SPUtility.h
//  Spots
//
//  Created by Nicholas Spitale on 7/10/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SPUtility : NSObject

+ (BOOL)userHasValidFacebookData:(PFUser *)user;
+ (void)addBottomDropShadowToNavigationBarForNavigationController:(UINavigationController *)navigationController;
@end
