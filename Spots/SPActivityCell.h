//
//  SPActivityCell.h
//  Spots
//
//  Created by Nicholas Spitale on 7/25/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPActivityCell : UITableViewCell
@property (nonatomic, strong) UIView *commentView;
@property (nonatomic, strong) UIButton *userButton, *placeButton;
@property (nonatomic, strong) UIImageView* userImage;
@property (nonatomic, strong) UILabel *timeLabel, *comments;
@end
