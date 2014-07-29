//
//  SPMapNavigationBar.m
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPMapNavigationBar.h"

@implementation SPMapNavigationBar
@synthesize headerView;
-(id)init{
    self = [super init];
    if(self) {
        
         headerView = [[UIView alloc] init];
    }
    return self;
}
/*
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
 */
- (void)drawRect:(CGRect)rect {
    UIView *view = [[UIView alloc] init];
    [headerView setBackgroundColor:[UIColor redColor]];
    [view drawRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
	//UIImage *image = [UIImage imageNamed:@"Custom-Nav-Bar-BG.png"];
	//[image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
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
