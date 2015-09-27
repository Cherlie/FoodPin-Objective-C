//
//  AddTableViewController.m
//  FoodPin
//
//  Created by uappx.cn on 15/9/12.
//  Copyright (c) 2015年 梅须白. All rights reserved.
//

#import "AddTableViewController.h"
#import "AppDelegate.h"

@interface AddTableViewController ()

@property (strong,nonatomic)NSArray* cellArray;

@end

@implementation AddTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.title = @"Add Resturant";
    UIBarButtonItem* cannelButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cannelButtonClick)];
    UIBarButtonItem* saveButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveButtonClick)];
    saveButton.tintColor = [UIColor whiteColor];
    cannelButton.tintColor = [UIColor whiteColor];
    self.navigationItem.rightBarButtonItem = saveButton;
    self.navigationItem.leftBarButtonItem = cannelButton;
    self.tableView.backgroundColor = [UIColor clearColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    //static cells from xib
    self.cellArray = @[self.imageCell,self.nameCell,self.typeCell,self.locationCell,self.isVisitedCell];
    if ([self.dictRestaurant count] > 0 && self.imageData != nil) {
        self.nameTextField.text = self.dictRestaurant[@"Name"];
        self.typeTextField.text = self.dictRestaurant[@"Type"];
        self.locationTextField.text = self.dictRestaurant[@"Location"];
        if ([self.dictRestaurant[@"IsVisited"]intValue] == 1) {
            [self yesButtonClick:nil];
        }else{
            [self noButtonClick:nil];
        }
        self.imageView.image = [UIImage imageWithData:self.imageData];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.cellArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: forIndexPath:indexPath];
    
    // Configure the cell...
    
    return [self.cellArray objectAtIndex:indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //pick image from picture library
    if (indexPath.row == 0) {
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]){
            UIImagePickerController* imagePicker = [[UIImagePickerController alloc]init];
            imagePicker.allowsEditing = false;
            imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
            imagePicker.delegate = self;
            
            [self presentViewController:imagePicker animated:YES completion:nil];
        }
    }
}

//show image to view when image picked
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    self.imageView.image = [info objectForKey:UIImagePickerControllerOriginalImage];
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    self.imageView.clipsToBounds = YES;
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

//auto row hight due to the cells height of xib files
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   UITableViewCell* cell = [self.cellArray objectAtIndex:indexPath.row];
   return cell.bounds.size.height;
}

//fix status bar changed to black bug
/*
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated{
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:NO];
}
 */

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)cannelButtonClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)showAlertViewTitle:(NSString*)title message:(NSString*)message{
    UIAlertController* alert = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)saveButtonClick{
    if (self.nameTextField.text.length == 0) {
        [self showAlertViewTitle:@"Oops" message:@"We can't proceed as you forget to fill in the resturant name.All fields are mandatory"];
        return;
    }
    
    if (self.typeTextField.text.length == 0) {
        [self showAlertViewTitle:@"Oops" message:@"We can't proceed as you forget to fill in the resturant type.All fields are mandatory"];

        return;
    }
    
    if (self.locationTextField.text.length == 0) {
        [self showAlertViewTitle:@"Oops" message:@"We can't proceed as you forget to fill in the resturant location.All fields are mandatory"];
        
        return;
    }
    
    //save data to core data
    //get managed object context from app delegate
    AppDelegate* delegate = [UIApplication sharedApplication].delegate;
    NSManagedObjectContext* managedObjectContext = delegate.managedObjectContext;
    if (managedObjectContext != nil) {
        self.restaurant = [NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];
        //insert
        self.restaurant.name = self.nameTextField.text;
        self.restaurant.type = self.typeTextField.text;
        self.restaurant.location = self.locationTextField.text;
        self.restaurant.image = UIImagePNGRepresentation(self.imageView.image);
        
        BOOL flag;
        //make sure this is Equal not == ,objective c doesn't rewrite ==
        if ([self.yesButton.backgroundColor isEqual:[UIColor redColor]]) {
            flag = YES;
        }else{
            flag = NO;
        }
        self.restaurant.isVisited = [[NSNumber alloc]initWithBool:flag];
        
        NSError* e = [[NSError alloc]init];
        if (![managedObjectContext save:&e]) {
            NSLog(@"insert error:%@",e.localizedDescription);
            return;
        }
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)yesButtonClick:(id)sender{
    self.noButton.backgroundColor = [UIColor lightGrayColor];
    self.yesButton.backgroundColor = [UIColor redColor];
}

- (IBAction)noButtonClick:(id)sender{
    self.noButton.backgroundColor = [UIColor redColor];
    self.yesButton.backgroundColor = [UIColor lightGrayColor];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
