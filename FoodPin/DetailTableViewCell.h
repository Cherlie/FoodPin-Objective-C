//
//  DetailTableViewCell.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/7.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailTableViewCell : UITableViewCell

@property (weak,nonatomic)IBOutlet UILabel* fieldLabel;
@property (weak,nonatomic)IBOutlet UILabel* valueLabel;
@property (weak,nonatomic)IBOutlet UIButton* mapButton;

@end
