//
//  CheckInViewController.h
//  Spots
//
//  Created by Nicholas Spitale on 7/16/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface SPCheckInViewController : UITableViewController <CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;
    NSMutableArray *people;
}
@property (nonatomic, retain) NSMutableArray *people;
@end
