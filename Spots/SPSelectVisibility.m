//
//  SPSelectVisibility.m
//  Spots
//
//  Created by Nicholas Spitale on 7/29/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//

#import "SPSelectVisibility.h"
#import "SPSelectVisibilityCell.h"
@interface SPSelectVisibility ()

@end

@implementation SPSelectVisibility

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[UIApplication sharedApplication] setStatusBarHidden:NO
                                            withAnimation:UIStatusBarAnimationFade];
    [self setTitle:@"Visibility"];
    [self.view setBackgroundColor:kSPColorLightGray];
     NSArray *facebookFriends = [[SPCache sharedCache] facebookFriends];
    NSLog(@"%@",facebookFriends);
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 300, 20)];
    [lbl setText:@"Select who you want to see this"];
    [lbl setFont:[UIFont systemFontOfSize:14.0f]];
    [lbl setAlpha:.8f];
    [self.view addSubview:lbl];
 
    UIView *btnContainer = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 113, self.view.frame.size.width, 50)];
    [btnContainer setBackgroundColor:kSPColorDarkGray];
    [self.view addSubview:btnContainer];
    
    
    UIButton *btnDoCheckIn = [[UIButton alloc] initWithFrame:CGRectMake(60, 7, 200, 36)];
    [btnDoCheckIn setBackgroundColor:kSPColorBlue];
    [btnDoCheckIn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btnDoCheckIn setTitle:@"Check In" forState:UIControlStateNormal];
    [btnDoCheckIn.titleLabel setFont:[UIFont systemFontOfSize:14.0f]];
    btnDoCheckIn.layer.cornerRadius = 5.0f;
   // [btnDoCheckIn addTarget:self action:@selector(goSelectVisibility) forControlEvents:UIControlEventTouchUpInside];
    [btnContainer addSubview:btnDoCheckIn];
    // Do any additional setup after loading the view.
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, 320, btnContainer.frame.origin.y - 40) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - UITableView


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
        // Load More Section
        return 60.0f;

}
- (NSInteger) tableView: (UITableView*) tableView numberOfRowsInSection: (NSInteger) section{
     NSArray *facebookFriends = [[SPCache sharedCache] facebookFriends];
    
    return [facebookFriends count];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
       SPSelectVisibilityCell *cell = (SPSelectVisibilityCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];


    
    if (cell == nil) {
        
        
        cell = [[SPSelectVisibilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.name setText:@"thisName"];
    return cell;
    

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
