//
//  SPActivityCell.m
//  Spots
//
//  Created by Nicholas Spitale on 7/25/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPActivityCell.h"
@interface SPActivityCell()
@property (nonatomic, strong) UIButton *userButton, *placeButton;
@property (nonatomic, strong) UIImageView* userImage;
@property (nonatomic, strong) UILabel *timeLabel, *comments;
@property (nonatomic, strong) UIView *commentView;
@end
@implementation SPActivityCell
@synthesize userButton, placeButton, userImage, timeLabel, commentView, comments;
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code

        [self.contentView setBackgroundColor:[UIColor whiteColor]];
 
        
        userImage = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
        [userImage setImage:[UIImage imageNamed:@"scarjo"]];
        
        userImage.layer.cornerRadius = roundf(userImage.frame.size.width / 2);
        userImage.layer.masksToBounds = YES;
        [self.contentView addSubview:userImage];
 
        [[UIButton appearance].titleLabel setTextAlignment:NSTextAlignmentLeft];
        
   
      
   
        
        userButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 10, 220, 20)];

        [userButton.titleLabel setTextAlignment:NSTextAlignmentLeft];
        [userButton.titleLabel setFont:[UIFont boldSystemFontOfSize:14.0f]];
        
        [userButton setTitle:@"Scarlett Johaannsen" forState:UIControlStateNormal];
        [userButton setTitleColor:kSPColorBlue forState:UIControlStateNormal];
        [self.contentView addSubview:userButton];
        
        placeButton = [[UIButton alloc] initWithFrame:CGRectMake(85, 35, 220, 20)];
        [placeButton setTitle:@"The Gold Mine" forState:UIControlStateNormal];
        [placeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [placeButton.titleLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [placeButton setBackgroundColor:[UIColor grayColor]];
        placeButton.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:placeButton];
        
        timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(85, 55, 220, 20)];
        [timeLabel setText:@"7:45pm"];
        [timeLabel setTextColor:[UIColor grayColor]];
        [timeLabel setFont:[UIFont systemFontOfSize:12.0f]];
        [self.contentView addSubview:timeLabel];
        
        //Reset widths to avoid having large touch area
        NSDictionary *attributes = @{NSFontAttributeName: self.userButton.titleLabel.font};
        CGSize textSize = [self.userButton.titleLabel.text sizeWithAttributes:attributes];
        [userButton setFrame:CGRectMake(userButton.frame.origin.x, userButton.frame.origin.y, textSize.width, userButton.frame.size.height)];
        
        //Reset widths to avoid having large touch area
        attributes = @{NSFontAttributeName: self.placeButton.titleLabel.font};
        textSize = [self.placeButton.titleLabel.text sizeWithAttributes:attributes];
        [placeButton setFrame:CGRectMake(placeButton.frame.origin.x, placeButton.frame.origin.y, textSize.width + 10, placeButton.frame.size.height)];

        commentView = [[UIView alloc] initWithFrame:CGRectMake(5, 80, 310, 40)];
        [commentView setBackgroundColor:[UIColor grayColor]];
        
        comments = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 300, 30)];
        [comments setFont:[UIFont systemFontOfSize:12.0f]];
        [comments setTextColor:[UIColor whiteColor]];
        comments.text = @"Lorem blah blan";
        [commentView addSubview:comments];
        commentView.layer.cornerRadius = 5.0f;
        [self.contentView addSubview:commentView];
        
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path,NULL,0.0,0.0);
        CGPathAddLineToPoint(path, NULL, 20.0f, 0.0f);
        CGPathAddLineToPoint(path, NULL, 10.0f, -10.0f);
        CGPathAddLineToPoint(path, NULL, 0.0f, 0.0f);

        
        
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        [shapeLayer setPath:path];
        [shapeLayer setFillColor:[[UIColor grayColor] CGColor]];
        [shapeLayer setStrokeColor:[[UIColor grayColor] CGColor]];
        [shapeLayer setBounds:CGRectMake(0.0f, 0.0f, 160.0f, 480)];
        [shapeLayer setAnchorPoint:CGPointMake(0.0f, 0.0f)];
        [shapeLayer setPosition:CGPointMake(25.0f, 3.0f)];
        [[[self commentView] layer] addSublayer:shapeLayer];
        
        
        
        
        
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
