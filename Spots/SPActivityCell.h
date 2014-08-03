//
//  SPActivityCell.h
//  Spots
//
//  Created by Nicholas Spitale on 7/25/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPProfileImageView.h"


@protocol SPActivityCellDelegate;

@interface SPActivityCell : UITableViewCell
@property (nonatomic, strong) UIView *commentView, *innerView;
@property (nonatomic, strong) UIButton *userButton, *placeButton, *mapButton;
@property (nonatomic, strong) UIImageView* userImage;
@property (nonatomic, strong) UILabel *userLabel, *timeLabel, *comments, *distanceLabel;
@property (nonatomic, strong) SPProfileImageView *userImageView;
@property (nonatomic,strong) PFUser *user;
@property (nonatomic, strong) id delegate;

@end

@protocol SPActivityCellDelegate <NSObject>
@optional

/*!
 Sent to the delegate when a user button is tapped
 @param aUser the PFUser of the user that was tapped
 */
- (void)cell:(SPActivityCell *)cellView didTapUserButton:(PFUser *)aUser;

@end
