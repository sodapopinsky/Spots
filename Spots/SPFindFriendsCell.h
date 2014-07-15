//
//  SPFindFriendsCell.h
//  Spots
//
//  Created by Nicholas Spitale on 7/15/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

@class SPProfileImageView;
@protocol SPFindFriendsCellDelegate;

@interface SPFindFriendsCell : UITableViewCell {
    id _delegate;
}

@property (nonatomic, strong) id<SPFindFriendsCellDelegate> delegate;

/*! The user represented in the cell */
@property (nonatomic, strong) PFUser *user;
@property (nonatomic, strong) UILabel *photoLabel;
@property (nonatomic, strong) UIButton *followButton;

/*! Setters for the cell's content */
- (void)setUser:(PFUser *)user;

- (void)didTapUserButtonAction:(id)sender;
- (void)didTapFollowButtonAction:(id)sender;

/*! Static Helper methods */
+ (CGFloat)heightForCell;

@end

/*!
 The protocol defines methods a delegate of a PAPFindFriendsCell should implement.
 */
@protocol SPFindFriendsCellDelegate <NSObject>
@optional

/*!
 Sent to the delegate when a user button is tapped
 @param aUser the PFUser of the user that was tapped
 */
- (void)cell:(SPFindFriendsCell *)cellView didTapUserButton:(PFUser *)aUser;
- (void)cell:(SPFindFriendsCell *)cellView didTapFollowButton:(PFUser *)aUser;

@end
