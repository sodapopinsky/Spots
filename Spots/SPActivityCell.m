//
//  SPActivityCell.m
//  Spots
//
//  Created by Nicholas Spitale on 7/25/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPActivityCell.h"

@implementation SPActivityCell
@synthesize userButton, innerView,userLabel, placeButton, userImage, timeLabel, commentView, comments, userImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
     //   [self setBackgroundColor:[UIColor colorWithRed:211.0f/255.0f green:214.0f/255.0f blue:219.0f/255.0f alpha:1.0f]];
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
 
        userImageView = [[SPProfileImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
        [self.contentView addSubview:userImageView];
        userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];

        
        userImage.layer.cornerRadius = roundf(userImage.frame.size.width / 2);
        userImage.layer.masksToBounds = YES;
        //[self.contentView addSubview:userImage];
 
        [[UIButton appearance].titleLabel setTextAlignment:NSTextAlignmentLeft];
        
        userButton = [[UIButton alloc] initWithFrame:CGRectMake(75, 15, 220, 20)];

        [userButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [userButton.titleLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [userButton setTitleColor:kSPColorLightGray forState:UIControlStateNormal];
        
         userLabel = [[UILabel alloc] initWithFrame:CGRectMake(75, 15, 180, 20)];
           [userLabel setFont:[UIFont boldSystemFontOfSize:13.0f]];
        [userLabel setTextColor:[UIColor blackColor]];
       // [userButton addTarget:self action:@selector(didTapUserButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:userLabel];
        
        placeButton = [[UIButton alloc] initWithFrame:CGRectMake(70, 35, 220, 20)];
        [placeButton setTitleColor:kSPColorBlue forState:UIControlStateNormal];
        [placeButton.titleLabel setFont:[UIFont boldSystemFontOfSize:15.0f]];

        placeButton.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:placeButton];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.contentView.frame.size.width - 85, 15, 80, 20)];
        [timeLabel setTextAlignment:NSTextAlignmentRight];
        [timeLabel setTextColor:[UIColor grayColor]];
        [timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        
        [self.contentView addSubview:timeLabel];
        
        
        /*
               commentView = [[UIView alloc] initWithFrame:CGRectMake(0,64,innerView.frame.size.width,50)];

      
        comments = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
        [comments setFont:[UIFont systemFontOfSize:13.0f]];
        [comments setTextColor:[UIColor blackColor]];

        [commentView addSubview:comments];

        */

        
  
        
        
    }
    return self;
}

#pragma mark - Delegate methods

/* Inform delegate that a user image or name was tapped */
- (void)didTapUserButtonAction:(id)sender {
    NSLog(@"tapparoo");
    if (self.delegate && [self.delegate respondsToSelector:@selector(cell:didTapUserButton:)]) {
        [self.delegate cell:self didTapUserButton:self.user];
    }
 
}


- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
