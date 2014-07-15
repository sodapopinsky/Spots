//
//  SPTimelineViewController.h
//  Spots
//
//  Created by Nicholas Spitale on 7/13/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SPTimelineHeaderView.h"
@interface SPTimelineViewController : PFQueryTableViewController <SPTimelineHeaderViewDelegate>

- (SPTimelineHeaderView *)dequeueReusableSectionHeaderView;


@end
