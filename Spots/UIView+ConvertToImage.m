//
//  UIView+ConvertToImage.m
//  Spots
//
//  Created by Nicholas Spitale on 7/21/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "UIView+ConvertToImage.h"

@implementation UIView (Convert)

-(UIImage *)convertViewToImage
{
    UIGraphicsBeginImageContext(self.bounds.size);
    [self drawViewHierarchyInRect:self.bounds afterScreenUpdates:YES];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

@end
