//
//  SPCheckInHeaderView.m
//  Spots
//
//  Created by Nicholas Spitale on 7/18/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckInHeaderView.h"

@interface SPCheckInHeaderView()
@property (nonatomic, strong) UIView *broadcastingToBarView;
@end

@implementation SPCheckInHeaderView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
