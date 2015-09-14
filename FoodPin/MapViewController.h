//
//  MapViewController.h
//  FoodPin
//
//  Created by uappx.cn on 15/9/12.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "Restaurant.h"

@interface MapViewController : UIViewController<MKMapViewDelegate>

@property (strong,nonatomic)MKMapView* mapView;
@property (strong,nonatomic)Restaurant* restaurant;

@end
