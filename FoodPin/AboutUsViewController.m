//
//  AboutUsViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/13.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "AboutUsViewController.h"
#import "WebViewController.h"

@interface AboutUsViewController ()

@end

@implementation AboutUsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"About Us";
    self.logoImageView = [[UIImageView alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 100, 90, 200, 200)];
    self.logoImageView.image = [UIImage imageNamed:@"about"];
    [self.view addSubview:self.logoImageView];
    
    self.remarkLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.view.bounds.size.width / 2 - 100, 300, 200, 50)];
    self.remarkLabel.textAlignment = NSTextAlignmentCenter;
    self.remarkLabel.lineBreakMode = NSLineBreakByWordWrapping;
    self.remarkLabel.numberOfLines = 0;
    [self.remarkLabel setText:@"Got Questions? \n You're just a tap away"];
    [self.remarkLabel setTextColor:[UIColor grayColor]];
    [self.view addSubview:self.remarkLabel];
    
    self.contactButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.contactButton setTitle:@"Contact Us" forState:UIControlStateNormal];
    self.contactButton.backgroundColor = [UIColor redColor];
    self.contactButton.tintColor = [UIColor whiteColor];
    self.contactButton.frame = CGRectMake(self.view.bounds.size.width / 2 - 100, 400, 200, 30);
    [self.contactButton addTarget:self action:@selector(sendEmail) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.contactButton];
    
    self.websiteButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.websiteButton setTitle:@"Visit our website" forState:UIControlStateNormal];
    self.websiteButton.backgroundColor = [UIColor redColor];
    self.websiteButton.tintColor = [UIColor whiteColor];
    self.websiteButton.frame = CGRectMake(self.view.bounds.size.width / 2 - 100, 435, 200, 30);
    [self.websiteButton addTarget:self action:@selector(gotoWebsite) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.websiteButton];
}

- (void)gotoWebsite{
    WebViewController* webViewController = [[WebViewController alloc]init];
    [self.navigationController pushViewController:webViewController animated:YES];
}

- (void)sendEmail{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController* composer = [[MFMailComposeViewController alloc]init];
        composer.mailComposeDelegate = self;
        [composer setToRecipients:@[@"cherlies_wang@outlook.com"]];
        composer.navigationBar.tintColor = [UIColor whiteColor];

        [self presentViewController:composer animated:YES completion:^{
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        }];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail Cancelled");
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail Saved");
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail Sent");
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Failed to send mail:%@",error.localizedDescription);
            break;
        default:
            break;
    }
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
