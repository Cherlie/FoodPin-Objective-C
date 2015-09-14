//
//  ShareViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/12.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "ShareViewController.h"

@interface ShareViewController ()

@end

@implementation ShareViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initilizeUI];
}

- (void)initilizeUI{
    self.backgroundImage = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.backgroundImage.image = [UIImage imageNamed:@"cafeloisl"];
    //blur effect of background image
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    [self.backgroundImage addSubview:blurEffectView];
    [self.view addSubview:self.backgroundImage];
    
    CGFloat xCenter = self.view.bounds.size.width / 2;
    self.facebookButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self button:self.facebookButton content:@"facebook" bgColor:[UIColor colorWithRed:66.0 / 255.0 green:14.0 / 255.0 blue:140.0 / 255.0 alpha:0.9] x:xCenter - 80 y:200 - 80];
    self.facebookButton.transform = CGAffineTransformMakeTranslation(0, - 1000);
    
    self.twitterButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self button:self.twitterButton content:@"twitter" bgColor:[UIColor colorWithRed:81.0 /255.0 green:116.0 / 255.0 blue:242.0 / 255.0 alpha:0.9] x:xCenter y:200 - 80];
    self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 1000);
    
    self.messageButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self button:self.messageButton content:@"message" bgColor:[UIColor colorWithRed:210.0 / 255.0 green:2.0 / 255.0 blue:0.0 / 255.0 alpha:0.9] x:xCenter - 80 y:200];
    self.messageButton.transform = CGAffineTransformMakeTranslation(0, -1000);
    
    self.emailButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self button:self.emailButton content:@"email" bgColor:[UIColor colorWithRed:251.0 / 255.0 green:132.0 / 255.0 blue:2.0 / 255.0 alpha:0.9] x:xCenter y:200];
    self.emailButton.transform = CGAffineTransformMakeTranslation(0, 1000);
    
    //close button
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setFrame:CGRectMake(self.view.bounds.size.width - 50, 40, 30, 30)];
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:nil action:@selector(dismissController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
}

//add four share image button to view
- (void)button:(UIButton*)button content:(NSString*)content bgColor:(UIColor*)color x:(CGFloat)x y:(CGFloat)y{
    //button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(x, y, 80, 80);
    button.tintColor = [UIColor whiteColor];
    button.backgroundColor = color;
    [button setImage:[UIImage imageNamed:content] forState:UIControlStateNormal];
    [self.view addSubview:button];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:1.0 delay:0.2 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.facebookButton.transform = CGAffineTransformMakeTranslation(0, 0);
        self.emailButton.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
    [UIView animateWithDuration:1.0 delay:0.5 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.twitterButton.transform = CGAffineTransformMakeTranslation(0, 0);
        self.messageButton.transform = CGAffineTransformMakeTranslation(0, 0);
    } completion:nil];
}

//close this view controller
- (void)dismissController{
    [self dismissViewControllerAnimated:YES completion:nil];
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
