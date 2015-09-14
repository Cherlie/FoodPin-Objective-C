//
//  MapViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/12.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.mapView = [[MKMapView alloc]initWithFrame:self.view.bounds];
    self.mapView.delegate = self;
    [self.view addSubview:self.mapView];
    
    CLGeocoder* geoCoder = [[CLGeocoder alloc]init];
    [geoCoder geocodeAddressString:self.restaurant.location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error != nil) {
            NSLog(@"%@",error);
            return;
        }
        if (placemarks != nil && [placemarks count] > 0) {
            CLPlacemark* placemark = [placemarks objectAtIndex:0];
            
            MKPointAnnotation* annotation = [[MKPointAnnotation alloc]init];
            annotation.title = self.restaurant.name;
            annotation.subtitle = self.restaurant.type;
            annotation.coordinate = placemark.location.coordinate;
            
            [self.mapView showAnnotations:@[annotation] animated:YES];
            [self.mapView selectAnnotation:annotation animated:YES];
        }
    }];
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation{
    NSString* identifier = @"MyPin";
    if ([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    MKAnnotationView* annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:identifier];
    if (annotationView == nil) {
        annotationView = [[MKAnnotationView alloc]initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
    }
    UIImageView* leftImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 53, 53)];
    leftImage.image = [UIImage imageWithData:self.restaurant.image];
    annotationView.leftCalloutAccessoryView = leftImage;
    
    return annotationView;
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
