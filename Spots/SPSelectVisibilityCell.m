//
//  SPSelectVisibilityCell.m
//  Spots
//
//  Created by Nicholas Spitale on 8/9/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPSelectVisibilityCell.h"

@implementation SPSelectVisibilityCell
@synthesize name, userAvatar;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        [self.contentView setBackgroundColor:[UIColor whiteColor]];
 
      name = [[UILabel alloc] initWithFrame:CGRectMake(5, 5, 250, 25)];
      [self addSubview:name];
        
        userAvatar = [[SPProfileImageView alloc] initWithFrame:CGRectMake(280, 5, 30, 30)];
        [self addSubview:userAvatar];
    }
    return self;
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
