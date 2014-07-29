//
//  SPCheckInNavigationController.h
//  Spots
//
//  Created by Nicholas Spitale on 7/28/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//


#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)


@interface SPCheckInNavigationController : UINavigationController <CLLocationManagerDelegate, MKMapViewDelegate, UITableViewDataSource, UITableViewDelegate  >
{
    CLLocationManager *locationManager;
    NSArray *places;
}

@property (nonatomic, retain) MKMapView *map;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *places;
@property (nonatomic, strong) UILabel *numSpotsLabel;
@end