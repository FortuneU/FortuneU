//
//  editGoalViewController.m
//  FortuneU
//
//  Created by User on 9/7/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "editGoalViewController.h"
#import "TargetViewController.h"
#import "Parse/Parse.h"

@interface editGoalViewController ()
@property (weak, nonatomic) IBOutlet UITextField *thingTextField;
@property (weak, nonatomic) IBOutlet UITextField *priceTextField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation editGoalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)onSave:(id)sender {
    
    
    if ([self.thingTextField.text isEqualToString:@""] || [self.priceTextField.text isEqualToString:@""]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                        message:@"All fields should be non-empty!"
                                                                 preferredStyle:(UIAlertControllerStyleAlert)];
        UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:^(UIAlertAction * _Nonnull action) {
                                                             // handle response here.
                                                         }];
        // add the OK action to the alert controller
        [alert addAction:okAction];
        [self presentViewController:alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    } else {
        PFUser *me = [PFUser currentUser];
        me[@"goalName"] = self.thingTextField.text;
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *price = [f numberFromString:self.priceTextField.text];
        me[@"goalPrice"] = price;
        me[@"goalDate"] = self.datePicker.date;
        me[@"goalStartDate"] = [NSDate date];
        [me saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error){
            if (succeeded) {
                [self.delegate didEditGoal:self.thingTextField.text price:self.priceTextField.text];
                [self dismissViewControllerAnimated:YES completion:nil];
            } else {
                UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                                                message:@"Unable to edit goal.\nPlease check your network connection!"
                                                                         preferredStyle:(UIAlertControllerStyleAlert)];
                UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                                   style:UIAlertActionStyleDefault
                                                                 handler:^(UIAlertAction * _Nonnull action) {
                                                                     // handle response here.
                                                                 }];
                // add the OK action to the alert controller
                [alert addAction:okAction];
                [self presentViewController:alert animated:YES completion:^{
                    // optional code for what happens after the alert controller has finished presenting
                }];
                [self dismissViewControllerAnimated:YES completion:nil];
                
            }
        }];
        
        
    }
    
    
}
- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
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
