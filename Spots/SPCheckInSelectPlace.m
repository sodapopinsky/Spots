//
//  SPCheckInSelectPlace.m
//  Spots
//
//  Created by Nicholas Spitale on 7/28/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckInSelectPlace.h"

@interface SPCheckInSelectPlace ()
@property CLLocation *currentLocation;
@end

@implementation SPCheckInSelectPlace
@synthesize currentLocation, map, places, numSpotsLabel;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        // Custom initialization
      
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
        

        
       
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    map = [[MKMapView alloc] initWithFrame:CGRectMake(0, 45, self.view.frame.size.width, 100)];
    map.delegate = self;
    [map setShowsUserLocation:YES];
    
    [self.view setBackgroundColor:[UIColor grayColor]];
    [self.view addSubview:map];
    
    UIButton *customPlace = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [customPlace setFrame:CGRectMake(0,145, self.view.frame.size.width, 55)];
    [customPlace setBackgroundColor:[UIColor redColor]];
    UIView *buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, customPlace.frame.size.width, 55)];
    [buttonView setBackgroundColor:kSPColorLightGray];
    
    UILabel *lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(15, 7, 200, 20)];
    [lbl1 setText:@"Add Custom Place"];
    [lbl1 setFont:[UIFont boldSystemFontOfSize:16.0f]];
    
    UILabel *lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(15, 28, 200, 20)];
    [lbl2 setText:@"Ex: Greg's New House"];
    [lbl2 setFont:[UIFont systemFontOfSize:13.0f]];
    
    [buttonView addSubview:lbl1];
    [buttonView addSubview:lbl2];
    
    [customPlace addSubview:buttonView];
    
    
    numSpotsLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 200, 300, 20)];
    [numSpotsLabel setTextColor:[UIColor whiteColor]];
 
    
    UIImageView *goCustom = [[UIImageView alloc] initWithFrame:CGRectMake(295, 15, 29*.5,.5 * 57)];
    [goCustom setImage:[UIImage imageNamed:@"RightArrow"]];
    [customPlace addSubview:goCustom];
    
    
    [numSpotsLabel setFont:[UIFont systemFontOfSize:12.0f]];
    
    [self.view addSubview:numSpotsLabel];
    [self.view addSubview:customPlace];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 220, self.view.frame.size.width, self.view.frame.size.height - 220)];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.view addSubview:self.tableView];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelButtonAction)];
    
#if TARGET_IPHONE_SIMULATOR
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=30.0046095,-90.18063130000002&types=bar|food|night_club&radius=100&key=%@",kGOOGLE_API_KEY];
    url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    currentLocation = [[CLLocation alloc] initWithLatitude:30.0046095 longitude:-90.18063130000002];
    [self queryGooglePlaces:url];
#else
    [locationManager startUpdatingLocation];
#endif
}

-(void)cancelButtonAction{
    [self.navigationController.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (void)mapView:(MKMapView *)mv didAddAnnotationViews:(NSArray *)views {
    MKCoordinateRegion region;
    region = MKCoordinateRegionMakeWithDistance(locationManager.location.coordinate,1000,1000);
    
    
    [mv setRegion:region animated:YES];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    
    NSLog(@"didFailWithError: %@", error);
    UIAlertView *errorAlert = [[UIAlertView alloc]
                               initWithTitle:@"Error" message:@"Failed to Get Your Location" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [errorAlert show];
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    
    currentLocation = newLocation;
    
    if (currentLocation != nil) {
        
        
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&types=bar|food&radius=250&key=%@",currentLocation.coordinate.latitude, currentLocation.coordinate.longitude,kGOOGLE_API_KEY];
        url = [url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
          [self queryGooglePlaces:url];

  
        
    }
    [locationManager stopUpdatingLocation];
    
}


-(void) queryGooglePlaces:(NSString*)url{
    // Build the url string to send to Google. NOTE: The kGOOGLE_API_KEY is a constant that should contain your own API key that you obtain from Google. See this link for more info:
    // https://developers.google.com/maps/documentation/places/#Authentication
    //  NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=5000&types=food&sensor=true&key=%@", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, kGOOGLE_API_KEY];
    
    
    
    
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        
    });
}

-(void)fetchedData:(NSData *)responseData {
  //  [MBProgressHUD hideHUDForView:self.view animated:YES];
    //parse out the json data
    NSError* error;
   
    NSDictionary* json = [NSJSONSerialization
                          JSONObjectWithData:responseData
                          
                          options:kNilOptions
                          error:&error];
  
    // NSLog(@"%@",json);
    //The results from Google will be an array obtained from the NSDictionary object with the key "results".
    places = [json objectForKey:@"results"];
    
    //Write out the data to the console.
    //  NSLog(@"Google Data: %@",json);
    
    
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
 
     [numSpotsLabel setText:[NSString stringWithFormat:@"We found %i spots we think you might be",[places count]]];
    // Return the number of rows in the section.
       return [places count];
   
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Check if a reusable cell object was dequeued
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }

    cell.textLabel.text = [[places objectAtIndex:indexPath.row] objectForKey:@"name"];
    
    
    
    
    
    NSDictionary *geometry = [[places objectAtIndex:indexPath.row] objectForKey:@"geometry"];
    NSDictionary *location = [geometry objectForKey:@"location"];
    NSLog(@"%@",geometry);
    
    CLLocationDegrees latitude = [[location objectForKey:@"lat"] doubleValue];
    CLLocationDegrees longitude = [[location objectForKey:@"lng"] doubleValue];
    NSLog(@"latitude of place:%f",[[geometry objectForKey:@"lat"] doubleValue]);
    NSLog(@"latitude of me:%f",currentLocation.coordinate.latitude);
    CLLocation *loc =  [[CLLocation alloc] initWithLatitude:latitude longitude:longitude];
    CLLocationDistance distance = round([loc getDistanceFrom:currentLocation]);
    NSLog(@"distance:%f",distance);
    
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%i meters",(int)distance];

    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
    //[tableView deselectRowAtIndexPath:indexPath animated:YES];
    /*
    SPCheckinCommentsViewController *nextController = [[SPCheckinCommentsViewController alloc] initWithPlace:[places objectAtIndex:indexPath.row]];
    NSLog(@"%@",[places objectAtIndex:indexPath.row]);
    
    [self.navigationController pushViewController:nextController animated:YES];
    */
}




- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
