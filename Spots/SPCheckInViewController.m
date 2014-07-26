//
//  CheckInViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/16/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckInViewController.h"
#import "SPCheckinCommentsViewController.h"
#import "UIView+ConvertToImage.h"
#import "UIImage+ImageEffects.h"
#import "MBProgressHUD.h"
#import "SPCheckinTVCell.h"

@interface SPCheckInViewController ()
@property CLLocation *currentLocation;
@property MBProgressHUD *hud;
@end

@implementation SPCheckInViewController
@synthesize currentLocation,places,hud;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
      
        // Custom initialization
        locationManager = [[CLLocationManager alloc] init];
        locationManager.delegate = self;
        locationManager.distanceFilter = kCLDistanceFilterNone;
        locationManager.desiredAccuracy = kCLLocationAccuracyBest;
      //  [locationManager startUpdatingLocation];
        
        
    }
    return self;
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
       // NSString *txt = [NSString stringWithFormat:@"%.8f", currentLocation.coordinate.longitude];
      
    }
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    [SPUtility setNavigationBarTintColor:self];
   
    [self setupAppearance];
 
    self.title = @"Check In";
   
    places = [[NSArray alloc] init];
    
    self.hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    self.hud.labelText = NSLocalizedString(@"Loading", nil);
    self.hud.dimBackground = NO;
  
    [self queryGooglePlaces];

   
    
}

-(void)setupAppearance{
    
    CALayer *capa = [self.navigationController navigationBar].layer;
    [capa setShadowColor: [[UIColor blackColor] CGColor]];
    [capa setShadowOpacity:0.85f];
    [capa setShadowOffset: CGSizeMake(0.0f, 1.5f)];
    [capa setShadowRadius:2.0f];
    [capa setShouldRasterize:YES];
    
    
    //Round
    CGRect bounds = capa.bounds;
    bounds.size.height += 10.0f;    //I'm reserving enough room for the shadow
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:bounds
                                                   byRoundingCorners:(UIRectCornerTopLeft | UIRectCornerTopRight)
                                                         cornerRadii:CGSizeMake(5.0, 5.0)];
    
    CAShapeLayer *maskLayer = [CAShapeLayer layer];
    maskLayer.frame = bounds;
    maskLayer.path = maskPath.CGPath;
    
    [capa addSublayer:maskLayer];
    capa.mask = maskLayer;
    self.view.layer.cornerRadius = 5.0f;
 
  
   
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop target:self action:@selector(cancelButtonAction:)];
    
    

    
}
-(void) queryGooglePlaces{
    // Build the url string to send to Google. NOTE: The kGOOGLE_API_KEY is a constant that should contain your own API key that you obtain from Google. See this link for more info:
    // https://developers.google.com/maps/documentation/places/#Authentication
  //  NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=%f,%f&radius=5000&types=food&sensor=true&key=%@", currentLocation.coordinate.latitude, currentLocation.coordinate.longitude, kGOOGLE_API_KEY];
    

    
        NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/search/json?location=30.0046095,-90.18063130000002&radius=5000&types=food&sensor=true&key=%@", kGOOGLE_API_KEY];
 
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
       
    });
}



-(void)fetchedData:(NSData *)responseData {
       [MBProgressHUD hideHUDForView:self.view animated:YES];
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
 //  NSLog(@"Google Data: %@", places);
 

    
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

    // Return the number of rows in the section.
    return [places count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    SPCheckinTVCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Check if a reusable cell object was dequeued
    if (cell == nil) {
       
        cell = [[SPCheckinTVCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
  //  [cell.contentView addSubview:cell.placeName];
    // Populate the cell with the appropriate name based on the indexPath
    cell.textLabel.text = [[places objectAtIndex:indexPath.row] objectForKey:@"name"];
 [cell.imageView setImage:[UIImage imageNamed:@"SpotIcon"]];
    cell.imageView.layer.cornerRadius = 5.0f;
    [cell.imageView setBackgroundColor:[UIColor colorWithRed:0.0f/255.0f green:124.0f/255.0f blue:179.0f/255.0f alpha:1.0f]];
    cell.detailTextLabel.text = @"5 miles";
    return cell;
}
-(void)viewWillAppear:(BOOL)animated{
    
      [self.navigationController.view setFrame:CGRectMake(10, 30, 300,[[UIScreen mainScreen] bounds].size.height - 40)];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
//[tableView deselectRowAtIndexPath:indexPath animated:YES];
    SPCheckinCommentsViewController *nextController = [[SPCheckinCommentsViewController alloc] initWithPlace:[places objectAtIndex:indexPath.row]];
    NSLog(@"%@",[places objectAtIndex:indexPath.row]);
    
    [self.navigationController pushViewController:nextController animated:YES];

}


#pragma mark - ()

- (void)cancelButtonAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
   
}
@end
