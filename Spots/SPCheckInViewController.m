//
//  CheckInViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/16/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckInViewController.h"
#import "SPCheckinCommentsViewController.h"

@interface SPCheckInViewController ()
@property CLLocation *currentLocation;
@end

@implementation SPCheckInViewController
@synthesize currentLocation, people;

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
    
    [self.navigationItem setTitle:@"Check In"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancelButtonAction:)];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"get" style:UIBarButtonItemStyleBordered target:self action:@selector(queryGooglePlaces)];

    people = [[NSMutableArray alloc] init];
    places = [[NSArray alloc] init];
    
    
    PFQuery *followingActivitiesQuery = [PFQuery queryWithClassName:kSPActivityClassKey];
    [followingActivitiesQuery whereKey:kSPActivityTypeKey equalTo:kSPActivityTypeFollow];
    [followingActivitiesQuery whereKey:kSPActivityToUserKey equalTo:[PFUser currentUser]];
    followingActivitiesQuery.limit = 1000;
    
    PFQuery *checkinsFromBroadcastingUsersQuery = [PFQuery queryWithClassName:kSPCheckInClassKey];
    [checkinsFromBroadcastingUsersQuery whereKey:kSPCheckInUserKey matchesKey:kSPActivityFromUserKey inQuery:followingActivitiesQuery];
    // [checkinsFromBroadcastingUsersQuery includeKey:kSPCheckInUserKey];
    
    PFQuery *myCheckins = [PFQuery queryWithClassName:kSPCheckInClassKey];
    [myCheckins whereKey:kSPCheckInUserKey equalTo:[PFUser currentUser]];
    
    PFQuery *query = [PFQuery orQueryWithSubqueries:[NSArray arrayWithObjects:checkinsFromBroadcastingUsersQuery,myCheckins, nil]];
    
    [query includeKey:kSPCheckInUserKey];
    
    // Issue the query
    [query findObjectsInBackgroundWithBlock:^(NSArray *songs, NSError *error) {
        if (error) return;
        
        // Songs now contains the last ten songs, and the band field has
        // been populated. For example:
        for (PFObject *song in songs) {
            
            // This does not require a network access.
            PFObject *band = [song objectForKey:@"user"];
            NSLog(@"%@",[band objectForKey:@"displayName"]);
            
        }
    }];
    
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
    for(NSMutableDictionary *place in places){
        [people addObject:[place objectForKey:@"name"]];
    }

    
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    // Check if a reusable cell object was dequeued
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Populate the cell with the appropriate name based on the indexPath
    cell.textLabel.text = [[places objectAtIndex:indexPath.row] objectForKey:@"name"];;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   // [super tableView:tableView didSelectRowAtIndexPath:indexPath];
    
//[tableView deselectRowAtIndexPath:indexPath animated:YES];
    SPCheckinCommentsViewController *nextController = [[SPCheckinCommentsViewController alloc] initWithPlace:[places objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:nextController animated:YES];

}


#pragma mark - ()

- (void)cancelButtonAction:(id)sender {
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
   
}
@end
