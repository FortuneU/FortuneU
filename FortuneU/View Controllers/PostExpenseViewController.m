//
//  PostExpenseViewController.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "PostExpenseViewController.h"
#import "Transaction.h"

@interface PostExpenseViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *memoField;

@property (strong, nonatomic) NSString *category;

@property (weak, nonatomic) IBOutlet UIButton *foodBtn;
@property (weak, nonatomic) IBOutlet UIButton *transportBtn;
@property (weak, nonatomic) IBOutlet UIButton *eduBtn;
@property (weak, nonatomic) IBOutlet UIButton *housingBtn;
@property (weak, nonatomic) IBOutlet UIButton *clothingBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UILabel *foodLabel;
@property (weak, nonatomic) IBOutlet UILabel *transportLabel;
@property (weak, nonatomic) IBOutlet UILabel *eduLabel;
@property (weak, nonatomic) IBOutlet UILabel *housingLabel;
@property (weak, nonatomic) IBOutlet UILabel *clothingLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;



@end

@implementation PostExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.category = nil;
}

- (IBAction)onClickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void) resetCategory {
    
    [self.foodBtn setImage:[UIImage imageNamed:@"Food_n.png"] forState:UIControlStateNormal];
    [self.transportBtn setImage:[UIImage imageNamed:@"Transport_n.png"] forState:UIControlStateNormal];
    [self.eduBtn setImage:[UIImage imageNamed:@"Education_n.png"] forState:UIControlStateNormal];
    [self.housingBtn setImage:[UIImage imageNamed:@"Housing_n.png"] forState:UIControlStateNormal];
    [self.clothingBtn setImage:[UIImage imageNamed:@"Clothing_n.png"] forState:UIControlStateNormal];
    [self.otherBtn setImage:[UIImage imageNamed:@"Other_n.png"] forState:UIControlStateNormal];
    
    [self.foodLabel setTextColor:[UIColor grayColor]];
    [self.transportLabel setTextColor:[UIColor grayColor]];
    [self.eduLabel setTextColor:[UIColor grayColor]];
    [self.housingLabel setTextColor:[UIColor grayColor]];
    [self.clothingLabel setTextColor:[UIColor grayColor]];
    [self.otherLabel setTextColor:[UIColor grayColor]];
    
}

- (IBAction)OnTapFood:(id)sender {
    [self resetCategory];
    [self.foodBtn setImage:[UIImage imageNamed:@"Food.png"] forState:UIControlStateNormal];
    [self.foodLabel setTextColor:[UIColor blackColor]];
    self.category = @"Food";
}

- (IBAction)OnTapTransport:(id)sender {
    [self resetCategory];
    [self.transportBtn setImage:[UIImage imageNamed:@"Transport.png"] forState:UIControlStateNormal];
    [self.transportLabel setTextColor:[UIColor blackColor]];
    self.category = @"Transportation";
}
- (IBAction)OnTapEdu:(id)sender {
    [self resetCategory];
    [self.eduBtn setImage:[UIImage imageNamed:@"Education.png"] forState:UIControlStateNormal];
    [self.eduLabel setTextColor:[UIColor blackColor]];
    self.category = @"Education";
}
- (IBAction)OnTapHousing:(id)sender {
    [self resetCategory];
    [self.housingBtn setImage:[UIImage imageNamed:@"Housing.png"] forState:UIControlStateNormal];
    [self.housingLabel setTextColor:[UIColor blackColor]];
    self.category = @"Housing";
}
- (IBAction)OnTapClothing:(id)sender {
    [self resetCategory];
    [self.clothingBtn setImage:[UIImage imageNamed:@"Clothing.png"] forState:UIControlStateNormal];
    [self.clothingLabel setTextColor:[UIColor blackColor]];
    self.category = @"Clothing";
}
- (IBAction)OnTapOther:(id)sender {
    [self resetCategory];
    [self.otherBtn setImage:[UIImage imageNamed:@"Other.png"] forState:UIControlStateNormal];
    [self.otherLabel setTextColor:[UIColor blackColor]];
    self.category = @"Other";
}

- (IBAction)onSave:(id)sender {
    
    if (!self.category) {
        UIAlertController *alert;
        alert = [UIAlertController alertControllerWithTitle:@"Warning"
                                                    message:@"Must select one category!"
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
    }
    
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *amount = [f numberFromString:self.amountField.text];
    
    
    
    [Transaction postTransactionWithAmount:amount withType:self.category withDate:self.datePicker.date withMemo:self.memoField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
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
            
        }
        
    }];
    
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
