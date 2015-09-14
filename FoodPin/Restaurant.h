//
//  Restaurant.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/5.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface Restaurant : NSManagedObject

@property (strong,nonatomic)NSString* name;
@property (strong,nonatomic)NSString* type;
@property (strong,nonatomic)NSString* location;
@property (strong,nonatomic)NSData* image;
@property (strong,nonatomic)NSNumber* isVisited;

- (id)initWithName:(NSString*)name type:(NSString*)type location:(NSString*)location image:(NSData*)image isVisited:(NSNumber*)isVisited;

@end
