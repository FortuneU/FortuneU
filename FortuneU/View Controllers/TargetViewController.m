//
//  TargetViewController.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "TargetViewController.h"
#import "editGoalViewController.h"
#import "Parse/Parse.h"

@interface TargetViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *goalImageView;
@property (weak, nonatomic) IBOutlet UILabel *goalNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goalPriceLabel;

@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self showGoal];
}

- (IBAction)onEdit:(id)sender {
    [self performSegueWithIdentifier:@"editGoal" sender:nil];
}

- (void) showGoal {
    PFUser *me = [PFUser currentUser];
    NSString *name = me[@"goalName"];
    NSNumber *price = me[@"goalPrice"];
    NSDate *date = me[@"goalDate"];
    if ((!name) || (!price) || (!date)) {
        self.goalNameLabel.text = @"No goal yet";
        self.goalPriceLabel.text = @"";
    } else {
        self.goalNameLabel.text = name;
        double p = [price doubleValue];
        self.goalPriceLabel.text = [NSString stringWithFormat:@"$%.2f",p];
    }
}

-(void) didEditGoal:(NSString *)name price:(NSString *)pString{
    self.goalNameLabel.text = name;
    NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
    f.numberStyle = NSNumberFormatterDecimalStyle;
    NSNumber *price = [f numberFromString:pString];
    double p = [price doubleValue];
    self.goalPriceLabel.text = [NSString stringWithFormat:@"$%.2f",p];
    
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([[segue identifier] isEqualToString:@"editGoal"]) {
        editGoalViewController *vc = (editGoalViewController*) [segue destinationViewController];
        vc.delegate = self;
    }
}


@end
