//
//  SPHomeViewController.h
//  Spots
//
//  Created by Nicholas Spitale on 7/12/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SPTimelineViewController.h"

@interface SPHomeViewController : SPTimelineViewController
@property (nonatomic, assign, getter = isFirstLaunch) BOOL firstLaunch;
@end
