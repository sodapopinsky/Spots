//
//  SPProfileImageView.h
//  Spots
//
//  Created by Nicholas Spitale on 7/14/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PFImageView;
@interface SPProfileImageView : UIView

@property (nonatomic, strong) UIButton *profileButton;
@property (nonatomic, strong) PFImageView *profileImageView;

- (void)setFile:(PFFile *)file;

@end
