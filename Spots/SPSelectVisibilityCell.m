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
