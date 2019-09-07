//
//  PostSaveViewController.m
//  FortuneU
//
//  Created by User on 9/7/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "PostSaveViewController.h"
#import "Transaction.h"

@interface PostSaveViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *memoField;


@end

@implementation PostSaveViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)onTapSave {
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *amount = [f numberFromString:self.amountField.text];
    
    
    
    [Transaction postTransactionWithAmount:amount withType:@"Save" withDate:self.datePicker.date withMemo:self.memoField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
        if (error != nil) {
            UIAlertController *alert;
            alert = [UIAlertController alertControllerWithTitle:@"Network Error"
                                                        message:@"Unable to save expense! Try again later!"
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
            [self.delegate2 updateRecord];
            PFUser *me = [PFUser currentUser];
            NSNumber * m = me[@"save"];
            double mm = [m doubleValue] + [amount doubleValue];
            me[@"save"] = [NSNumber numberWithDouble:mm];
            [me saveInBackgroundWithBlock:nil];
            [self dismissViewControllerAnimated:YES completion: ^{[self.delegate2 updateRecord];}];
        }
        
    }];
}
    



@end
