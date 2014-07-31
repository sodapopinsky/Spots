//
//  SPSelectVisibilityCell.h
//  Spots
//
//  Created by Nicholas Spitale on 7/31/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SPSelectVisibilityCell : UITableViewCell

+ (CGFloat)heightForCell;
- (void)setUser:(PFUser *)user;

@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) UILabel *photoLabel;
@property (nonatomic, strong) UIButton *followButton;
@end
