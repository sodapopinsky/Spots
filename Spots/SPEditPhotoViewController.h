//
//  SPEditPhotoViewController.h
//  Spots
//
//  Created by Nicholas Spitale on 7/16/14.
//  Copyright (c) 2014 NickSpitale. All rights reserved.
//
@protocol SPEditPhotoDelegate;
@interface SPEditPhotoViewController : UIViewController <UITextFieldDelegate, UIScrollViewDelegate>

- (id)initWithImage:(UIImage *)aImage;
@property (nonatomic, strong) id delegate;
@end

@protocol SPEditPhotoDelegate <NSObject>
-(void)testFunction;
@optional
@end