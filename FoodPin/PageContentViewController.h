//
//  PageContentViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PageContentViewController : UIViewController

@property (weak,nonatomic)IBOutlet UILabel* headingLabel;
@property (weak,nonatomic)IBOutlet UILabel* subHeadingLabel;
@property (weak,nonatomic)IBOutlet UIImageView* contentImageView;
@property (weak,nonatomic)IBOutlet UIPageControl* pageControl;

@property (weak,nonatomic)IBOutlet UIButton* getStartButton;
@property (weak,nonatomic)IBOutlet UIButton* forwardButton;

- (IBAction)close:(id)sender;
- (IBAction)nextScreen:(id)sender;

@property int index;
@property (strong,nonatomic)NSString* heading;
@property (strong,nonatomic)NSString* imageFile;
@property (strong,nonatomic)NSString* subHeading;

@end
