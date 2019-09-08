//
//  PostIncomeViewController.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "PostIncomeViewController.h"
#import "PostViewController.h"
#import "Transaction.h"
#import "Parse/Parse.h"



@interface PostIncomeViewController () 
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *memoField;
@property (weak, nonatomic) IBOutlet UIButton *salaryBtn;
@property (weak, nonatomic) IBOutlet UIButton *InvestmentBtn;
@property (weak, nonatomic) IBOutlet UIButton *ScholarshipBtn;
@property (weak, nonatomic) IBOutlet UIButton *ReimbursementBtn;
@property (weak, nonatomic) IBOutlet UIButton *otherBtn;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@property (weak, nonatomic) IBOutlet UILabel *reimbursementLabel;
@property (weak, nonatomic) IBOutlet UILabel *salaryLabel;
@property (weak, nonatomic) IBOutlet UILabel *scholarshipLabel;
@property (weak, nonatomic) IBOutlet UILabel *investmentLabel;
@property (weak, nonatomic) IBOutlet UILabel *otherLabel;


@property (strong, nonatomic) NSString *category;

@end

@implementation PostIncomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.category = nil;
}

- (void) resetCategory {
    
    [self.salaryBtn setImage:[UIImage imageNamed:@"salary_n.png"] forState:UIControlStateNormal];
    [self.InvestmentBtn setImage:[UIImage imageNamed:@"invest_n.png"] forState:UIControlStateNormal];
    [self.ScholarshipBtn setImage:[UIImage imageNamed:@"scholarship_n.png"] forState:UIControlStateNormal];
    [self.ReimbursementBtn setImage:[UIImage imageNamed:@"reimburse_n.png"] forState:UIControlStateNormal];
    [self.otherBtn setImage:[UIImage imageNamed:@"otheri_n.png"] forState:UIControlStateNormal];
    
    [self.salaryLabel setTextColor:[UIColor grayColor]];
    [self.investmentLabel setTextColor:[UIColor grayColor]];
    [self.scholarshipLabel setTextColor:[UIColor grayColor]];
    [self.otherLabel setTextColor:[UIColor grayColor]];
    [self.reimbursementLabel setTextColor:[UIColor grayColor]];
    
}


- (IBAction)salaryBtn:(id)sender {
    [self resetCategory];
    [self.salaryBtn setImage:[UIImage imageNamed:@"salary.png"] forState:UIControlStateNormal];
    [self.salaryLabel setTextColor:[UIColor blackColor]];
    self.category = @"Salary";
}

- (IBAction)investmentBtn:(id)sender {
    [self resetCategory];
    [self.InvestmentBtn setImage:[UIImage imageNamed:@"invest.png"] forState:UIControlStateNormal];
    [self.investmentLabel setTextColor:[UIColor blackColor]];
    self.category = @"Investment";
}
- (IBAction)scholarshipBtn:(id)sender {
    [self resetCategory];
    [self.ScholarshipBtn setImage:[UIImage imageNamed:@"scholarship.png"] forState:UIControlStateNormal];
    [self.scholarshipLabel setTextColor:[UIColor blackColor]];
    self.category = @"Scholarship";
}
- (IBAction)reimbursementBtn:(id)sender {
    [self resetCategory];
    [self.ReimbursementBtn setImage:[UIImage imageNamed:@"reimburse.png"] forState:UIControlStateNormal];
    [self.reimbursementLabel setTextColor:[UIColor blackColor]];
    self.category = @"Reimbursement";
}
- (IBAction)otherBtn:(id)sender {
    [self resetCategory];
    [self.otherBtn setImage:[UIImage imageNamed:@"otheri.png"] forState:UIControlStateNormal];
    [self.otherLabel setTextColor:[UIColor blackColor]];
    self.category = @"OtherI";
}

- (void)onTapSave {
    if ([self.amountField.text isEqualToString:@""]) {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                                        message:@"Amount cannot be non-empty!"
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
    } else if (!self.category) {
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
    } else {
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
                [self.delegate2 updateRecord];
                PFUser *me = [PFUser currentUser];
                NSNumber * m = me[@"in"];
                double mm = [m doubleValue] + [amount doubleValue];
                me[@"in"] = [NSNumber numberWithDouble:mm];
                [me saveInBackgroundWithBlock:nil];
                [self dismissViewControllerAnimated:YES completion: ^{[self.delegate2 updateRecord];}];
            }
            
        }];
    }
    
    
    
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
