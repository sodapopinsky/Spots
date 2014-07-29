//
//  SPCheckinTVCell.m
//  Spots
//
//  Created by Nicholas Spitale on 7/21/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckinTVCell.h"

@implementation SPCheckinTVCell
@synthesize placeName;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        [self.contentView setFrame:CGRectMake(self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, 80.0f)];

        [self.textLabel setFont:[UIFont systemFontOfSize:14.0f]];
        [self.detailTextLabel setAlpha:0.8f];
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
