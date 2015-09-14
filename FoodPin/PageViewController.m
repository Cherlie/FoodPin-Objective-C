//
//  PageViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "PageViewController.h"
#import "PageContentViewController.h"

@interface PageViewController ()

@property (strong,nonatomic)NSArray* pageHeading;
@property (strong,nonatomic)NSArray* pageImages;
@property (strong,nonatomic)NSArray* pageSubHeadings;

@end

@implementation PageViewController

@synthesize pageHeading = _pageHeading;
@synthesize pageImages = _pageImages;
@synthesize pageSubHeadings = _pageSubHeadings;

- (NSArray*)pageHeading{
    return @[@"Personalize",@"Locate",@"Discover"];
}

- (NSArray*)pageImages{
    return @[@"homei",@"mapintro",@"fiveleaves"];
}

- (NSArray*)pageSubHeadings{
    return @[@"Pin your favourite restaurants and create your own food guide", @"Search and locate your favourite restaurant on Maps", @"Find restaurants pinned by your friends and other foodies around the world"];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    
    PageContentViewController* pageContent = (PageContentViewController*)viewController;
    int index = pageContent.index;
    index++;
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    
    PageContentViewController* pageContent = (PageContentViewController*)viewController;
    int index = pageContent.index;
    index--;
    return [self viewControllerAtIndex:index];
}

- (PageContentViewController*)viewControllerAtIndex:(int)index{
    if (index <0 || index >= [self.pageSubHeadings count]) {
        return nil;
    }
    PageContentViewController* pageContentViewController = [[PageContentViewController alloc]init];
    pageContentViewController.imageFile = [self.pageImages objectAtIndex:index];
    pageContentViewController.heading = [self.pageHeading objectAtIndex:index];
    pageContentViewController.subHeading = [self.pageSubHeadings objectAtIndex:index];
    pageContentViewController.index = index;
    
    return pageContentViewController;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.dataSource = self;
    PageContentViewController* startingViewController = [self viewControllerAtIndex:0];
    if (startingViewController) {
        [self setViewControllers:@[startingViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

- (void)forwardIndex:(int)Index{
    PageContentViewController* nextViewController = [self viewControllerAtIndex:Index + 1];
    [self setViewControllers:@[nextViewController] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
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
