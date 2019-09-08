//
//  editGoalViewController.m
//  FortuneU
//
//  Created by User on 9/7/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "editGoalViewController.h"

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
}
- (IBAction)onCancel:(id)sender {
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
