//
//  SPDiscoverViewController.m
//  Spots
//
//  Created by Nicholas Spitale on 7/12/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPDiscoverViewController.h"
#define kBgQueue dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)

@interface SPDiscoverViewController ()

@end

@implementation SPDiscoverViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor blueColor]];
    
    
    NSString *url = [NSString stringWithFormat:@"https://maps.googleapis.com/maps/api/place/photo?maxwidth=50&maxheight=50&photoreference=CnRnAAAAU8k7HpHSw8RnYO2zunxdNpfkKJECbcV1U1J3UIwNdhFZa6LLq7725qnMxDBx07WDUgP14lmlIUdr6g3d2XVw5hmyeQ2UvU4dk0WDnFfyiZb9pnKmkUvC3nkIPTxguKS363PLin_vdrXo-2iLTVf2ahIQGnuL8Mv6fKyHavEKYIyZJRoU4Ak2nzFTZW897sxQeFulA07Y1Lo&key=%@",kGOOGLE_API_KEY];
    
    //Formulate the string as a URL object.
    NSURL *googleRequestURL=[NSURL URLWithString:url];
    
    // Retrieve the results of the URL.
    dispatch_async(kBgQueue, ^{
        NSData* data = [NSData dataWithContentsOfURL: googleRequestURL];
        [self performSelectorOnMainThread:@selector(fetchedData:) withObject:data waitUntilDone:YES];
        
    });
    
}

-(void)fetchedData:(NSData *)responseData {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 50, 50, 50)];
    [imageView setBackgroundColor:[UIColor grayColor]];
    UIImage *image = [[UIImage alloc] initWithData:responseData];
    
    [imageView setImage:image];
    [self.view addSubview:imageView];
}
@end
