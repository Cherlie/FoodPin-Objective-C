//
//  PageContentViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "PageContentViewController.h"
#import "PageViewController.h"

@interface PageContentViewController ()

@end

@implementation PageContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.headingLabel.text = self.heading;
    self.subHeadingLabel.text = self.subHeading;
    self.contentImageView.image = [UIImage imageNamed:self.imageFile];
    self.pageControl.currentPage = self.index;
    
    self.getStartButton.hidden = self.index == 2 ? NO : YES;
    self.forwardButton.hidden = self.index == 2 ? YES : NO;
}

- (IBAction)close:(id)sender{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setBool:YES forKey:@"hasViewedWalkthrough"];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)nextScreen:(id)sender{
    PageViewController* pageViewController = (PageViewController*)self.parentViewController;
    [pageViewController forwardIndex:self.index];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
