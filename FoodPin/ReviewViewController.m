//
//  ReviewViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/10.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()

@end

@implementation ReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.bgImageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    self.bgImageView.image = [UIImage imageNamed:@"cafeloisl"];
    //blur effect of background image
    UIBlurEffect* blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    UIVisualEffectView* blurEffectView = [[UIVisualEffectView alloc]initWithEffect:blurEffect];
    blurEffectView.frame = self.view.bounds;
    [self.bgImageView addSubview:blurEffectView];
    
    [self.view addSubview:self.bgImageView];
    //a dialog view which make app looks more natrue
    self.dialogView = [[UIView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 115, 102, 231, 242)];
    //the dialog is zero size
    CGAffineTransform scale = CGAffineTransformMakeScale(0.0, 0.0);
    CGAffineTransform translate = CGAffineTransformMakeTranslation(0, 500);
    self.dialogView.transform = CGAffineTransformConcat(scale, translate);
    
    UILabel* label = [[UILabel alloc]initWithFrame:CGRectMake(35, 30, 200, 80)];
    label.text = @"You’ve dined here.\n     What did you \n\t\t think?";
    label.font = [UIFont fontWithName:@"Avenir Next Medium" size:18];
    label.textColor = [UIColor whiteColor];
    //line break
    label.numberOfLines = 0;
    label.lineBreakMode = NSLineBreakByWordWrapping;
    
    [self addButtonsContent:@"bad" x:15 y:140];
    [self addButtonsContent:@"good" x:85 y:140];
    [self addButtonsContent:@"great" x:155 y:140];
    
    //close button
    UIButton* closeButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [closeButton setFrame:CGRectMake(self.view.bounds.size.width - 50, 40, 30, 30)];
    closeButton.tintColor = [UIColor whiteColor];
    [closeButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    [closeButton addTarget:nil action:@selector(dismissController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];

    [self.dialogView addSubview:label];
    [self.view addSubview:self.dialogView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [UIView animateWithDuration:0.7 delay:0.0 usingSpringWithDamping:0.6 initialSpringVelocity:0.5 options:UIViewAnimationOptionTransitionNone animations:^{
        CGAffineTransform scale = CGAffineTransformMakeScale(1, 1);
        CGAffineTransform translate = CGAffineTransformMakeTranslation(0.0, 0.0);
        self.dialogView.transform = CGAffineTransformConcat(scale, translate);
    } completion:nil];
}

//add three image button to view
- (void)addButtonsContent:(NSString*)content x:(CGFloat)x y:(CGFloat)y{
    UIButton* button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(x, y, 60, 60);
    button.backgroundColor = [UIColor redColor];
    [button setImage:[UIImage imageNamed:content] forState:UIControlStateNormal];
    //set the tint color to white
    button.tintColor = [UIColor whiteColor];
    button.layer.cornerRadius = 30;
    [self.dialogView addSubview:button];
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
