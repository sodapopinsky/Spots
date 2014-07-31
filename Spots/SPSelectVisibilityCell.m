//
//  SPSelectVisibilityCell.m
//  Spots
//
//  Created by Nicholas Spitale on 7/31/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPSelectVisibilityCell.h"
#import "SPProfileImageView.h"

@interface SPSelectVisibilityCell()
    @property (nonatomic, strong) UIButton *nameButton;
    @property (nonatomic, strong) UIButton *avatarImageButton;
    @property (nonatomic, strong) SPProfileImageView *avatarImageView;
@end

@implementation SPSelectVisibilityCell
@synthesize user, avatarImageView, nameButton, photoLabel, followButton;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

+ (CGFloat)heightForCell {
    return 67.0f;
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


#pragma mark - PAPFindFriendsCell

- (void)setUser:(PFUser *)aUser {
    user = aUser;
    
    // Configure the cell
    [avatarImageView setFile:[self.user objectForKey:kSPUserProfilePicSmallKey]];
    
    // Set name
    NSString *nameString = [self.user objectForKey:kSPUserDisplayNameKey];
    CGSize nameSize = [nameString boundingRectWithSize:CGSizeMake(144.0f, CGFLOAT_MAX)
                                               options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                            attributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:16.0f]}
                                               context:nil].size;
    [nameButton setTitle:[self.user objectForKey:kSPUserDisplayNameKey] forState:UIControlStateNormal];
    [nameButton setTitle:[self.user objectForKey:kSPUserDisplayNameKey] forState:UIControlStateHighlighted];
    
    [nameButton setFrame:CGRectMake( 60.0f, 17.0f, nameSize.width, nameSize.height)];
    
    // Set photo number label
    CGSize photoLabelSize = [@"photos" boundingRectWithSize:CGSizeMake(144.0f, CGFLOAT_MAX)
                                                    options:NSStringDrawingTruncatesLastVisibleLine|NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:11.0f]}
                                                    context:nil].size;
    [photoLabel setFrame:CGRectMake( 60.0f, 17.0f + nameSize.height, 140.0f, photoLabelSize.height)];
    
    // Set follow button
    [followButton setFrame:CGRectMake( 208.0f, 20.0f, 103.0f, 32.0f)];
}


@end
