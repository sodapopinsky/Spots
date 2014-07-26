//
//  SPActivityCell.m
//  Spots
//
//  Created by Nicholas Spitale on 7/25/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPActivityCell.h"

@implementation SPActivityCell
@synthesize userButton, placeButton, userImage, timeLabel, commentView, comments, userImageView;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        [self.contentView setBackgroundColor:kSPColorLightGray];
        
        userImageView = [[SPProfileImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [self.contentView addSubview:userImageView];
        userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [userImage setImage:[UIImage imageNamed:@"scarjo"]];
        
        userImage.layer.cornerRadius = roundf(userImage.frame.size.width / 2);
        userImage.layer.masksToBounds = YES;
        //[self.contentView addSubview:userImage];
 
        [[UIButton appearance].titleLabel setTextAlignment:NSTextAlignmentLeft];
        
   
      
   
        
        userButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 10, 220, 20)];

        [userButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [userButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        [userButton setTitleColor:kSPColorBlue forState:UIControlStateNormal];
        [userButton addTarget:self action:@selector(didTapUserButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:userButton];
        
        placeButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 35, 220, 20)];
        [placeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [placeButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [placeButton setBackgroundColor:[UIColor grayColor]];
        placeButton.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:placeButton];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 55, 220, 20)];
        [timeLabel setTextColor:[UIColor grayColor]];
        [timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.contentView addSubview:timeLabel];
        
    
        commentView = [[UIView alloc] initWithFrame:CGRectMake(5, 80, 310, 40)];
        [commentView setBackgroundColor:[UIColor whiteColor]];
        
        comments = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
        [comments setFont:[UIFont systemFontOfSize:12.0f]];
        [comments setTextColor:[UIColor grayColor]];
        [commentView addSubview:comments];
        commentView.layer.cornerRadius = 5.0f;
     
        
        
  
        
        
        
        
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
