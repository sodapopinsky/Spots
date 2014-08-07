//
//  SPProfileImageView.m
//  Spots
//
//  Created by Nicholas Spitale on 7/14/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//
#import "SPProfileImageView.h"

@interface SPProfileImageView ()

@end

@implementation SPProfileImageView


@synthesize profileImageView;
@synthesize profileButton;


#pragma mark - NSObject

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        self.profileImageView = [[PFImageView alloc] initWithFrame:frame];
   
        [self addSubview:self.profileImageView];
        
        self.profileButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [self addSubview:self.profileButton];
        
  

        [profileImageView.layer setBorderColor: [kSPColorGray CGColor]];
        [profileImageView.layer setBorderWidth: 3.0];
        self.profileImageView.layer.cornerRadius = roundf(self.profileImageView .frame.size.width / 2);
         self.profileImageView.layer.masksToBounds = YES;
            self.profileImageView.image = [UIImage imageNamed:@"AvatarPlaceholder.png"];
    }
    return self;
}


#pragma mark - UIView

- (void)layoutSubviews {
    [super layoutSubviews];

    
    self.profileImageView.frame = CGRectMake( 1.0f, 0.0f, self.frame.size.width, self.frame.size.height);

    self.profileButton.frame = CGRectMake( 0.0f, 0.0f, self.frame.size.width, self.frame.size.height);
}


#pragma mark - PAPProfileImageView

- (void)setFile:(PFFile *)file {
    if (!file) {
        return;
    }
    
    self.profileImageView.image = [UIImage imageNamed:@"AvatarPlaceholder.png"];
    self.profileImageView.file = file;
    [self.profileImageView loadInBackground];
}

@end
