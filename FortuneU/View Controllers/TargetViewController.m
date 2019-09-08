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

@property (weak, nonatomic) IBOutlet UILabel *exhaustionLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceLabel;
@property (weak, nonatomic) IBOutlet UILabel *exhaustionTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeTextLabel;
@property (weak, nonatomic) IBOutlet UILabel *distanceTextLabel;


@property (weak, nonatomic) IBOutlet UIView *exhaustionView;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;

@property (assign,nonatomic) BOOL goalReached;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@end

@implementation TargetViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self renew];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(renew) forControlEvents:UIControlEventValueChanged];
    [self.scrollView insertSubview:self.refreshControl atIndex:0];
}

- (void) renew {
    [self showGoal];
    [self showBarGraphs];
    [self.refreshControl endRefreshing];
}

- (void) initializeBarGraphs {
    self.exhaustionLabel.textColor = [UIColor colorWithRed:235.0/255 green:143.0/255 blue:144.0/255 alpha:1.0];
    self.timeLabel.textColor = [UIColor colorWithRed:255/255 green:180.0/255 blue:113.0/255 alpha:1.0];
    self.distanceLabel.textColor = [UIColor colorWithRed:134.0/255 green:157.0/255 blue:171.0/255 alpha:1.0];
    
    self.exhaustionTextLabel.textColor = [UIColor colorWithRed:235.0/255 green:143.0/255 blue:144.0/255 alpha:1.0];
    self.timeTextLabel.textColor = [UIColor colorWithRed:255/255 green:180.0/255 blue:113.0/255 alpha:1.0];
    self.distanceTextLabel.textColor = [UIColor colorWithRed:134.0/255 green:157.0/255 blue:171.0/255 alpha:1.0];
    
    PFUser *me = [PFUser currentUser];
    NSNumber *income = me[@"in"];
    NSNumber *expense = me[@"out"];
    self.exhaustionTextLabel.text = [NSString stringWithFormat:@"$%d left",([income intValue] - [expense intValue])];
    
    NSDate *due = me[@"goalDate"];
    NSNumber *price = me[@"goalPrice"];
    if (!due || !price) {
        self.timeTextLabel.text = @"No due yet";
        self.distanceLabel.text = @"No goal yet";
    } else {
        NSDate *now = [NSDate date];
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        // Notice the components:NSDayCalendarUnit specifier
        NSDateComponents *components = [calendar components:NSCalendarUnitDay
                                                            fromDate:now
                                                              toDate:due
                                                             options:0];
        long numDays = [components day];
        if (numDays < 0) {
            self.timeTextLabel.text = @"Past due";
        } else {
            self.timeTextLabel.text = [NSString stringWithFormat:@"%ld days left",numDays];
        }
        
        NSNumber *save = me[@"save"];
        int distance = ([price intValue] - [save intValue]);
        if (distance <= 0) {
            self.goalReached = YES;
            self.distanceTextLabel.text = [NSString stringWithFormat:@"Yayyy!"];
        } else {
            self.goalReached = NO;
            self.distanceTextLabel.text = [NSString stringWithFormat:@"$%d to save", distance];
            
        }
    }
}

- (void) showBarGraphs {
    [self initializeBarGraphs];
    
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
