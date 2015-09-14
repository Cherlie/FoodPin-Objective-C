//
//  AboutUsViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>

@interface AboutUsViewController : UIViewController<MFMailComposeViewControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic)UIImageView* logoImageView;
@property (strong,nonatomic)UILabel* remarkLabel;
@property (strong,nonatomic)UIButton* contactButton;
@property (strong,nonatomic)UIButton* websiteButton;

@end
