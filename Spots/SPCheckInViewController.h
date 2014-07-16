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
@interface SPCheckInViewController : UITableViewController <CLLocationManagerDelegate>

{
    CLLocationManager *locationManager;

}

@end
