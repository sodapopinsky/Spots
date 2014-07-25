//
//  SPPhotoHeaderView.m
//  Spots
//
//  Created by Nicholas Spitale on 7/13/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPTimelineHeaderView.h"
#import "SPProfileImageView.h"
#import "TTTTimeIntervalFormatter.h"
#import "SPUtility.h"

@interface SPTimelineHeaderView ()
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) SPProfileImageView *avatarImageView;
@property (nonatomic, strong) UIButton *userButton;
@property (nonatomic, strong) UILabel *placeLabel;
@property (nonatomic, strong) UILabel *timestampLabel;
@property (nonatomic, strong) UIImageView *map;
@property (nonatomic, strong) TTTTimeIntervalFormatter *timeIntervalFormatter;
@end


@implementation SPTimelineHeaderView
@synthesize containerView;
@synthesize avatarImageView;
@synthesize userButton;
@synthesize timestampLabel;
@synthesize timeIntervalFormatter;
@synthesize photo;
@synthesize buttons;
@synthesize delegate;
@synthesize placeLabel, map;

#pragma mark - Initialization

- (id)initWithFrame:(CGRect)frame buttons:(SPTimelineHeaderButtons)otherButtons {
    self = [super initWithFrame:frame];
    if (self) {
        
        [SPTimelineHeaderView validateButtons:otherButtons];
        buttons = otherButtons;
        
        self.clipsToBounds = NO;
        self.containerView.clipsToBounds = NO;
        self.superview.clipsToBounds = NO;
        [self.containerView setBackgroundColor:[UIColor redColor]];
        
        // translucent portion
        self.containerView = [[UIView alloc] initWithFrame:CGRectMake( 10.0f, 0.0f, self.bounds.size.width - 10.0f * 2.0f, self.bounds.size.height)];
     
        [self addSubview:self.containerView];
      
        
        
        self.avatarImageView = [[SPProfileImageView alloc] init];
        self.avatarImageView.frame = CGRectMake( 5.0f, 0.0f, 50.0f, 50.0f);
        [self.avatarImageView.layer setMasksToBounds:YES];
    
        // make new layer to contain shadow and masked image
        CALayer* containerLayer = [CALayer layer];
        /*
        containerLayer.shadowColor = [UIColor blackColor].CGColor;
        containerLayer.shadowRadius = 10.f;
        containerLayer.shadowOffset = CGSizeMake(0.f, 5.f);
        containerLayer.shadowOpacity = 1.f;
         */
        self.avatarImageView.layer.borderWidth = 3.0f;
        self.avatarImageView.layer.borderColor = [UIColor grayColor].CGColor;

        
        // use the image's layer to mask the image into a circle
       avatarImageView.layer.cornerRadius = 10.0f;
        avatarImageView.layer.masksToBounds = YES;
        
        // add masked image layer into container layer so that it's shadowed
        [containerLayer addSublayer:avatarImageView.layer];
        
        // add container including masked image and shadow into view
        [self.containerView.layer addSublayer:containerLayer];
        
        [self.avatarImageView.profileButton addTarget:self action:@selector(didTapUserButtonAction:) forControlEvents:UIControlEventTouchUpInside];
       // [self.containerView addSubview:self.avatarImageView];
        
 
        if (self.buttons & SPTimelineHeaderButtonsUser) {
            // This is the user's display name, on a button so that we can tap on it
            self.userButton = [UIButton buttonWithType:UIButtonTypeCustom];
           
            [containerView addSubview:self.userButton];
            [self.userButton setBackgroundColor:[UIColor clearColor]];
            [[self.userButton titleLabel] setFont:[UIFont systemFontOfSize:14.0f]];
            [self.userButton setTitleColor:kSPColorBlue forState:UIControlStateNormal];

            [[self.userButton titleLabel] setLineBreakMode:NSLineBreakByTruncatingTail];
            [[self.userButton titleLabel] setShadowOffset:CGSizeMake( 0.0f, 1.0f)];
            [self.userButton setTitleShadowColor:[UIColor colorWithWhite:1.0f alpha:0.750f] forState:UIControlStateNormal];
   
        }
        
        //place
        self.placeLabel = [[UILabel alloc] initWithFrame:CGRectMake(90.0f, 24.0f, containerView.bounds.size.width -10.0f-90.0f, 18.0f)];
      //  [containerView addSubview:self.placeLabel];
        [self.placeLabel setShadowColor:[UIColor colorWithWhite:1.0f alpha:0.750f]];
        [self.placeLabel setShadowOffset:CGSizeMake( 0.0f, 1.0f)];
        [self.placeLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [self.placeLabel setTextColor:kSPColorBlue];
        
        [self.placeLabel setBackgroundColor:[UIColor clearColor]];
        
        self.timeIntervalFormatter = [[TTTTimeIntervalFormatter alloc] init];
       
        
        // timestamp
        self.timestampLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 55.0f, 60.0f, 18.0f)];
        [self.timestampLabel setTextAlignment:NSTextAlignmentCenter];
        [containerView addSubview:self.timestampLabel];
        [self.timestampLabel setTextColor:[UIColor colorWithRed:124.0f/255.0f green:124.0f/255.0f blue:124.0f/255.0f alpha:1.0f]];
        [self.timestampLabel setShadowColor:[UIColor colorWithWhite:1.0f alpha:0.750f]];
        [self.timestampLabel setShadowOffset:CGSizeMake( 0.0f, 1.0f)];
        [self.timestampLabel setFont:[UIFont systemFontOfSize:11.0f]];
        [self.timestampLabel setBackgroundColor:[UIColor clearColor]];
        
        [self.containerView addSubview:self.placeLabel];
     
        /*
        CALayer *layer = [containerView layer];
        layer.backgroundColor = [[UIColor whiteColor] CGColor];
        layer.masksToBounds = NO;
        layer.shadowRadius = 1.0f;
        layer.shadowOffset = CGSizeMake( 0.0f, 2.0f);
        layer.shadowOpacity = 0.5f;
        layer.shouldRasterize = YES;
        layer.shadowPath = [UIBezierPath bezierPathWithRect:CGRectMake( 0.0f, containerView.frame.size.height - 4.0f, containerView.frame.size.width, 4.0f)].CGPath;
         */
    }
    
    return self;
}


#pragma mark - PAPPhotoHeaderView

- (void)setPhoto:(PFObject *)aPhoto {
    photo = aPhoto;
 
    PFObject *user = [aPhoto objectForKey:@"user"];
    
    PFFile *profilePictureSmall = [user objectForKey:kSPUserProfilePicSmallKey];
    [self.avatarImageView setFile:profilePictureSmall];
    
    NSString *authorName = [user objectForKey:kSPUserDisplayNameKey];
    [self.userButton setTitle:authorName forState:UIControlStateNormal];
    
    CGFloat constrainWidth = containerView.bounds.size.width;
    
    if (self.buttons & SPTimelineHeaderButtonsUser) {
        [self.userButton addTarget:self action:@selector(didTapUserButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (self.buttons & SPTimelineHeaderButtonsComment) {
        /*
        constrainWidth = self.commentButton.frame.origin.x;
        [self.commentButton addTarget:self action:@selector(didTapCommentOnPhotoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        */
    }
    
    if (self.buttons & SPTimelineHeaderButtonsLike) {
        /*
        constrainWidth = self.likeButton.frame.origin.x;
        [self.likeButton addTarget:self action:@selector(didTapLikePhotoButtonAction:) forControlEvents:UIControlEventTouchUpInside];
         */
     
    }
    
    // we resize the button to fit the user's name to avoid having a huge touch area
    CGPoint userButtonPoint = CGPointMake(65.0f,0.0f);
    constrainWidth -= userButtonPoint.x;
    CGSize constrainSize = CGSizeMake(constrainWidth, containerView.bounds.size.height - userButtonPoint.y*2.0f);
    
    CGSize userButtonSize = [self.userButton.titleLabel.text sizeWithFont:self.userButton.titleLabel.font constrainedToSize:constrainSize lineBreakMode:NSLineBreakByTruncatingTail];


    CGRect userButtonFrame = CGRectMake(userButtonPoint.x, userButtonPoint.y, userButtonSize.width, userButtonSize.height);
 //  [SP] should constrain size of button, couldnt figure it out
   userButtonFrame = CGRectMake(userButtonPoint.x, userButtonPoint.y, 210.0f, userButtonSize.height);
    [self.userButton setFrame:userButtonFrame];
    
    NSTimeInterval timeInterval = [[self.photo createdAt] timeIntervalSinceNow];
    NSString *timestamp = [self.timeIntervalFormatter stringForTimeInterval:timeInterval];
    [self.timestampLabel setText:timestamp];
    
    NSString *place = [self.photo objectForKey:kSPCheckInPlaceNameKey];
    [self.placeLabel setText:place];
    
    [self setNeedsDisplay];
}


#pragma mark - ()

+ (void)validateButtons:(SPTimelineHeaderButtons)buttons {
    if (buttons == SPTimelineHeaderButtonsNone) {
        [NSException raise:NSInvalidArgumentException format:@"Buttons must be set before initializing SPTimelineHeaderView."];
    }
}

- (void)didTapUserButtonAction:(UIButton *)sender {
    if (delegate && [delegate respondsToSelector:@selector(photoHeaderView:didTapUserButton:user:)]) {
        [delegate photoHeaderView:self didTapUserButton:sender user:[self.photo objectForKey:kSPPhotoUserKey]];
    }
}

@end

