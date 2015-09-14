//
//  CustomTableViewCell.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/4.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell

@property (weak,nonatomic)IBOutlet UILabel* nameLabel;
@property (weak,nonatomic)IBOutlet UILabel* locationLabel;
@property (weak,nonatomic)IBOutlet UILabel* typeLabel;
@property (weak,nonatomic)IBOutlet UIImageView* thumbnailImageView;

@end
