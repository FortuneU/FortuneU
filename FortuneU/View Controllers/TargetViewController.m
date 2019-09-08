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


@property (weak, nonatomic) IBOutlet UIButton *goalBtn;


@property (weak, nonatomic) IBOutlet UIView *exhaustionView;
@property (weak, nonatomic) IBOutlet UIView *timeView;
@property (weak, nonatomic) IBOutlet UIView *distanceView;

@property (assign,nonatomic) BOOL goalReached;

@property (nonatomic, strong) UIRefreshControl *refreshControl;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *pathView;

@property (weak, nonatomic) IBOutlet UIImageView *goalNewImageView;




@end

@implementation TargetViewController
UIImageView *human;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.goalNewImageView.alpha = 0;
    self.goalBtn.alpha = 0;
    self.goalBtn.userInteractionEnabled = NO;
    [self renew];
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(renew) forControlEvents:UIControlEventValueChanged];
    [self.scrollView insertSubview:self.refreshControl atIndex:0];
}
- (IBAction)onTapNewGoal:(id)sender {
    self.goalNameLabel.text = @"No goal yet";
    self.goalPriceLabel.text = @"";
    PFUser *me = [PFUser currentUser];
    double k = [me[@"save"] doubleValue] - [me[@"goalPrice"] doubleValue];
    me[@"save"] = [NSNumber numberWithDouble:k];
    me[@"goalName"] = [NSNull null];
    me[@"goalPrice"] = [NSNull null];
    me[@"goalDate"] = [NSNull null];
    me[@"goalStartDate"] = [NSNull null];
    [me saveInBackgroundWithBlock:nil];
    self.goalReached = NO;
    self.goalNewImageView.alpha = 0;
    self.goalBtn.alpha = 0;
    self.goalBtn.userInteractionEnabled = NO;
    [self renew];
}

- (void) renew {
    [self showGoal];
    [self initializeBarGraphs];
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
    
    self.exhaustionView.backgroundColor = [UIColor whiteColor];
    self.exhaustionView.layer.borderColor = [UIColor colorWithRed:235.0/255 green:143.0/255 blue:144.0/255 alpha:1.0].CGColor;
    self.exhaustionView.layer.borderWidth = 1.5;
    
    self.timeView.backgroundColor = [UIColor whiteColor];
    self.timeView.layer.borderWidth = 1.5;
    self.timeView.layer.borderColor = [UIColor colorWithRed:255/255 green:180.0/255 blue:113.0/255 alpha:1.0].CGColor;
    
    self.distanceView.backgroundColor = [UIColor whiteColor];
    self.distanceView.layer.borderWidth = 1.5;
    self.distanceView.layer.borderColor = [UIColor colorWithRed:134.0/255 green:157.0/255 blue:171.0/255 alpha:1.0].CGColor;
}

- (void) showBarGraphs {
    PFUser *me = [PFUser currentUser];
    NSNumber *income = me[@"in"];
    NSNumber *expense = me[@"out"];
    self.exhaustionTextLabel.text = [NSString stringWithFormat:@"$%d left",([income intValue] + [expense intValue])];
    
    NSDate *due = me[@"goalDate"];
    NSNumber *price = me[@"goalPrice"];
    if (!due || !price || [due isKindOfClass:[NSNull class]] || [price isKindOfClass:[NSNull class]] ) {
        self.timeTextLabel.text = @"No due yet";
        self.distanceTextLabel.text = @"No goal yet";
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
        if ((distance - 0) <= 0.01) {
            self.goalReached = YES;
            self.distanceTextLabel.text = [NSString stringWithFormat:@"Yayyy!"];
            self.goalBtn.alpha = 1;
            self.goalNewImageView.alpha = 1;
            self.goalBtn.userInteractionEnabled = YES;
        } else {
            self.goalReached = NO;
            self.distanceTextLabel.text = [NSString stringWithFormat:@"$%d to save", distance];
            self.goalBtn.alpha = 0;
            self.goalNewImageView.alpha = 0;
            self.goalBtn.userInteractionEnabled = NO;
            
        }
        if (!save) {
            self.goalReached = NO;
            self.distanceTextLabel.text = [NSString stringWithFormat:@"$%d to save", distance];
            self.goalBtn.alpha = 0;
            self.goalNewImageView.alpha = 0;
            self.goalBtn.userInteractionEnabled = NO;
        }
    }
    
    
    UIView *subExhaustionView = [[UIView alloc] init];
    CGRect currentFrame = subExhaustionView.frame;
    currentFrame.origin.x = 0;
    currentFrame.origin.y = 0;
    currentFrame.size.height = 20;
    
    if ([expense doubleValue] == 0) {
        currentFrame.size.width = 0;
    } else if ([income doubleValue]== 0) {
        currentFrame.size.width = self.exhaustionView.frame.size.width;
    } else {
        double temp = - [expense doubleValue] / [income doubleValue];
        currentFrame.size.width = self.exhaustionView.frame.size.width * temp;
    }
    subExhaustionView.frame = currentFrame;
    subExhaustionView.backgroundColor = [UIColor colorWithRed:235.0/255 green:143.0/255 blue:144.0/255 alpha:1.0];
    [self.exhaustionView addSubview:subExhaustionView];
    
    
    UIView *subTimeView = [[UIView alloc] init];
    CGRect timeFrame = subTimeView.frame;
    timeFrame.origin.x = 0;
    timeFrame.origin.y = 0;
    timeFrame.size.height = 20;
    if ([self.timeTextLabel.text isEqualToString: @"No due yet"]) {
        timeFrame.size.width = 0;
    } else if ([self.timeTextLabel.text isEqualToString:@"Past due"]) {
        timeFrame.size.width = self.timeView.frame.size.width;
    } else {
        NSDate *now = [NSDate date];
        NSDate *first = me[@"goalStartDate"];
        NSCalendar *calendar1 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        // Notice the components:NSDayCalendarUnit specifier
        NSDateComponents *components1 = [calendar1 components:NSCalendarUnitDay
                                                   fromDate:first
                                                     toDate:now
                                                    options:0];
        long numDaysHasStarted = [components1 day];
        if (numDaysHasStarted == 0) {
            timeFrame.size.width = 0;
        } else {
            NSCalendar *calendar2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
            
            // Notice the components:NSDayCalendarUnit specifier
            NSDateComponents *components2 = [calendar2 components:NSCalendarUnitDay
                                                         fromDate:now
                                                           toDate:due
                                                          options:0];
            long numDaysTillDue = [components2 day];
            
            
            timeFrame.size.width = (double)(numDaysHasStarted + 1) / (numDaysHasStarted + numDaysTillDue + 1) * self.timeView.frame.size.width;
        }
    }
    subTimeView.frame = timeFrame;
    subTimeView.backgroundColor = [UIColor colorWithRed:255/255 green:180.0/255 blue:113.0/255 alpha:1.0];
    [self.timeView addSubview:subTimeView];
    
    
    NSNumber *hasSaved = me[@"save"];
    UIView *subDistanceView = [[UIView alloc] init];
    CGRect dFrame = subDistanceView.frame;
    dFrame.origin.x = 0;
    dFrame.origin.y = 0;
    dFrame.size.height = 20;
    if ((!price) || ([price isKindOfClass:[NSNull class]]) || ([price doubleValue] == 0) || ([hasSaved doubleValue]== 0)) {
        dFrame.size.width = 0;
        if (!human) {
            human = [[UIImageView alloc]init];
            [human setImage:[UIImage imageNamed:@"LV1.png"]];
        }
        CGRect humanFrame = human.frame;
        humanFrame.origin.x = 0 * self.pathView.frame.size.width - 30;
        humanFrame.origin.y = - 30;
        humanFrame.size.height = 30;
        humanFrame.size.width = 30;
        human.frame = humanFrame;
        [self.pathView addSubview:human];
    } else {
        if (!human) {
            human = [[UIImageView alloc]init];
            [human setImage:[UIImage imageNamed:@"LV1.png"]];
        }
        double percentage = [hasSaved doubleValue] / [price doubleValue];
        if (percentage > 1) {
            percentage = 1;
        }
        dFrame.size.width = self.distanceView.frame.size.width * percentage;
        CGRect humanFrame = human.frame;
        humanFrame.origin.x = percentage * self.pathView.frame.size.width - 30;
        humanFrame.origin.y = - 30;
        humanFrame.size.height = 30;
        humanFrame.size.width = 30;
        human.frame = humanFrame;
        [self.pathView addSubview:human];
    }
    subDistanceView.frame = dFrame;
    subDistanceView.backgroundColor = [UIColor colorWithRed:134.0/255 green:157.0/255 blue:171.0/255 alpha:1.0];
    [self.distanceView addSubview:subDistanceView];
    
    
    
    
    
    
}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd EEE hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
}

- (IBAction)onEdit:(id)sender {
    [self performSegueWithIdentifier:@"editGoal" sender:nil];
}

- (void) showGoal {
    PFUser *me = [PFUser currentUser];
    NSString *name = me[@"goalName"];
    NSNumber *price = me[@"goalPrice"];
    NSDate *date = me[@"goalDate"];
    if ((!name) || (!price) || (!date) || ([name isKindOfClass:[NSNull class]]) || ([price isKindOfClass:[NSNull class]]) || ([date isKindOfClass:[NSNull class]])) {
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
