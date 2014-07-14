//
//  SPPhotoHeaderView.h
//  Spots
//
//  Created by Nicholas Spitale on 7/13/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <Foundation/Foundation.h>


typedef enum {
    SPTimelineHeaderButtonsNone = 0,
   
    SPTimelineHeaderButtonsLike = 1 << 0,
    SPTimelineHeaderButtonsComment = 1 << 1,
    SPTimelineHeaderButtonsUser = 1 << 2,
    
   // PAPPhotoHeaderButtonsDefault = PAPPhotoHeaderButtonsLike | PAPPhotoHeaderButtonsComment | PAPPhotoHeaderButtonsUser
    
} SPTimelineHeaderButtons;

@protocol SPTimelineHeaderViewDelegate;

@interface SPTimelineHeaderView : UIView

/*! @name Creating Photo Header View */
/*!
 Initializes the view with the specified interaction elements.
 @param buttons A bitmask specifying the interaction elements which are enabled in the view
 */
- (id)initWithFrame:(CGRect)frame buttons:(SPTimelineHeaderButtons)otherButtons;

/// The photo associated with this view
@property (nonatomic,strong) PFObject *photo;

/// The bitmask which specifies the enabled interaction elements in the view
@property (nonatomic, readonly, assign) SPTimelineHeaderButtons buttons;


/*! @name Delegate */
@property (nonatomic,weak) id <SPTimelineHeaderViewDelegate> delegate;


@end


/*!
 The protocol defines methods a delegate of a PAPPhotoHeaderView should implement.
 All methods of the protocol are optional.
 */
@protocol SPTimelineHeaderViewDelegate <NSObject>
@optional

/*!
 Sent to the delegate when the user button is tapped
 @param user the PFUser associated with this button
 */
- (void)photoHeaderView:(SPTimelineHeaderView *)photoHeaderView didTapUserButton:(UIButton *)button user:(PFUser *)user;


@end