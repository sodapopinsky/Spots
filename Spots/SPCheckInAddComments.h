//
//  SPCheckInAddComments.h
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@interface SPCheckInAddComments : UIViewController < UIImagePickerControllerDelegate, MKMapViewDelegate,UITextViewDelegate>
-(id)initWithPlace:(NSDictionary *)place;
@property (nonatomic, retain) UIButton *addPhoto;
@property (nonatomic, retain) MKMapView *map;
@end
