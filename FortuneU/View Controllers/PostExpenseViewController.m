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


@end

@implementation PostExpenseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)onClickCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (IBAction)onSave:(id)sender {
    //get category name
    
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *amount = [f numberFromString:self.amountField.text];
    
    
    /*
    [Transaction postTransactionWithAmount:amount withType:<#(NSString * _Nullable)#> withDate:self._datePicker.date withMemo:self.memoField.text withCompletion:^(BOOL succeeded, NSError * _Nullable error) {
        
    }];
    */
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
