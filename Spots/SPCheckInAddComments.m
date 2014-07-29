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
@property (nonatomic, strong) UITextView *comments;
@end

@implementation SPCheckInAddComments
@synthesize place, map, comments;

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
 self.navigationController.navigationBarHidden = YES;

    [self setTitle:[place objectForKey:@"name"]];
    [self.view setBackgroundColor:kSPColorLightGray];
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 95)];
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
    

    UIButton *cancel = [UIButton buttonWithType:UIButtonTypeCustom];
    [cancel setFrame:CGRectMake(10, 10, 40, 40)];
    [cancel setImage:[UIImage imageNamed:@"RightArrow"] forState:UIControlStateNormal];
    [cancel addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancel];

    
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 95,320, 45)];
    [buttonView setBackgroundColor:[UIColor whiteColor]];
    [buttonView setAlpha:0.6f];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
    [lbl1 setText:@"Visible to 7 followers"];
    [lbl1 setFont:[UIFont systemFontOfSize:15.0f]];
    [buttonView addSubview:lbl1];

    [self.view addSubview:buttonView];
    
    UIImageView *goCustom = [[UIImageView alloc] initWithFrame:CGRectMake(295, 5, 29*.5,.5 * 57)];
    [goCustom setImage:[UIImage imageNamed:@"RightArrow"]];
    [buttonView addSubview:goCustom];
  
   
    
    comments = [[UITextView alloc] initWithFrame:CGRectMake(10, 145, 300, 75)];
    [comments setBackgroundColor:[UIColor whiteColor]];
    comments.layer.borderColor = kSPColorDarkGray.CGColor;
    comments.layer.cornerRadius = 3.0f;
    
    [comments becomeFirstResponder];
    
    [self.view addSubview:comments];
    UIButton *btnDoCheckIn = [[UIButton alloc] initWithFrame:CGRectMake(175, 228, 135, 30)];
    [btnDoCheckIn setBackgroundColor:[UIColor colorWithRed:255.0f/255.0f green:150.0f/255.0f blue:24.0f/255.0f alpha:1.0f]];
    [btnDoCheckIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDoCheckIn setShowsTouchWhenHighlighted:YES];
    [btnDoCheckIn setTitle:@"Check In" forState:UIControlStateNormal];
    btnDoCheckIn.layer.cornerRadius = 5.0f;
    [btnDoCheckIn addTarget:self action:@selector(doCheckin) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btnDoCheckIn];
    
    
}

-(void)dismiss{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)doCheckin{
    
}


@end
