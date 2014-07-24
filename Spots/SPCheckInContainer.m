//
//  SPCheckInVC.m
//  Spots
//
//  Created by Nicholas Spitale on 7/21/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPCheckInContainer.h"
#import "SPCheckInViewController.h"

@interface SPCheckInContainer ()
@property (nonatomic, retain) UIImage* backgroundImage;
@end

@implementation SPCheckInContainer
@synthesize backgroundImage;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
       
    }
    return self;
}
-(id)initWithBackgroundImage:(UIImage *)image
{
    self = [super init];
    if (self) {
        // Custom initialization
         backgroundImage = image;
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //[self.view setBackgroundColor:[UIColor clearColor]];
    
 
    
    self.view.backgroundColor = [UIColor clearColor];
    UIImageView* backView = [[UIImageView alloc] initWithFrame:self.view.frame];
    backView.image = backgroundImage;
    backView.backgroundColor = [[UIColor redColor] colorWithAlphaComponent:0.6];
    
    [self.view addSubview:backView];
    
    SPCheckInViewController *c = [[SPCheckInViewController alloc] init];
  

    UINavigationController *myNav = [[UINavigationController alloc] initWithRootViewController:c];
    [self addChildViewController:myNav];

    [myNav willMoveToParentViewController:self];
    myNav.view.frame = CGRectMake(10,30 , 300, self.view.frame.size.height - 60);  //Set a frame or constraints
    
   
    
    
    [self.view addSubview:myNav.view];
    [self addChildViewController:myNav];
    [myNav didMoveToParentViewController:self];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
