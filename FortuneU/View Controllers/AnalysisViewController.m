//
//  AnalysisViewController.m
//  FortuneU
//
//  Created by User on 9/8/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "AnalysisViewController.h"

@interface AnalysisViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *segmentedCtrl;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation AnalysisViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.segmentedCtrl.selectedSegmentIndex = 0;
    [self.imageView setImage:[UIImage imageNamed:@"income.png"]];
}
- (IBAction)OnSegmentedCtrl:(id)sender {
    if (self.segmentedCtrl.selectedSegmentIndex == 0) {
        [self.imageView setImage:[UIImage imageNamed:@"income.png"]];
    } else if (self.segmentedCtrl.selectedSegmentIndex == 1) {
        [self.imageView setImage:[UIImage imageNamed:@"expense.png"]];
    } else {
        [self.imageView setImage:[UIImage imageNamed:@"savings.png"]];
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
