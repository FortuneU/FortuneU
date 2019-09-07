//
//  PostViewController.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "PostViewController.h"

@interface PostViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentCtrl;
@property (weak, nonatomic) IBOutlet UIView *postExpenseView;
@property (weak, nonatomic) IBOutlet UIView *postIncomeView;

@end

@implementation PostViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.segmentCtrl.selectedSegmentIndex = 1;
    // Do any additional setup after loading the view.
    /*
    CGFloat width = [UIScreen mainScreen].bounds.size.width * 0.4;
    [self.segmentCtrl setWidth:width forSegmentAtIndex:0];
    [self.segmentCtrl setWidth:width forSegmentAtIndex:1];
    //self.segmentctrl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.segmentCtrl.layer.borderWidth = 2.0f;
    self.segmentCtrl.layer.cornerRadius = 8;
    self.segmentCtrl.clipsToBounds = true;
     */
    
}
- (IBAction)onSwitchSegment:(id)sender {
    if (self.segmentCtrl.selectedSegmentIndex == 0) {
        self.postExpenseView.alpha = 0;
        self.postIncomeView.alpha = 1;
    } else {
        self.postExpenseView.alpha = 1;
        self.postIncomeView.alpha = 0;
    }
}
- (IBAction)onCancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)onSave:(id)sender {
    
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
