//
//  Restaurant.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/5.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "Restaurant.h"

@implementation Restaurant

@dynamic name;
@dynamic type;
@dynamic location;
@dynamic image;
@dynamic isVisited;

- (id)initWithName:(NSString*)name type:(NSString*)type location:(NSString*)location image:(NSData*)image isVisited:(NSNumber*)isVisited {
    self = [super init];
    if(self){
        self.name = name;
        self.type = type;
        self.location = location;
        self.image = image;
        self.isVisited = isVisited;
    }
    return self;
}

@end
