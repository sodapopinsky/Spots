//
//  SPCheckInAddComments.m
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckInAddComments.h"


@interface SPCheckInAddComments ()
@property (nonatomic, retain) NSDictionary* place;
@end

@implementation SPCheckInAddComments
@synthesize place, map;

-(id)initWithPlace:(NSDictionary *)placeObject
{
    self = [super init];
    if (self != nil)
    {
        place = placeObject;
      
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setTitle:[place objectForKey:@"name"]];
    
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 100)];
    map.delegate = self;
    [self.view addSubview:map];
     [map setShowsUserLocation:YES];
 
    NSDictionary *geometry = [place objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    
    CLLocationDegrees latitude = [[location objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitude = [[location objectForKey:@"lng"] doubleValue];


    MKCoordinateRegion region;
    
    CLLocationCoordinate2D placeCoord;
    // Set the lat and long.
    placeCoord.latitude=latitude;
    placeCoord.longitude=longitude;
    region = MKCoordinateRegionMakeWithDistance(placeCoord,1000,1000);
    
    [map setRegion:region animated:YES];
    
    
    
    
}


@end
