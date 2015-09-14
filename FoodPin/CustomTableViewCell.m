//
//  CustomTableViewCell.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/4.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.thumbnailImageView.layer.cornerRadius = self.thumbnailImageView.bounds.size.width / 2;
    self.thumbnailImageView.clipsToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
