//
//  RecordViewController.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "RecordViewController.h"
#import "TransactionCell.h"
#import "Transaction.h"

@interface RecordViewController () <UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSArray *transactions;
@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
- (IBAction)onTapPlusButton:(id)sender {
    [self performSegueWithIdentifier:@"compose" sender:nil];
}



- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TransactionCellView" bundle:nil] forCellReuseIdentifier:@"TransactionCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionCell"];
    }
    
    Transaction *transaction = self.transactions[indexPath.row];
    NSString *category = transaction[@"type"];
    
    //get icon view according to category
    NSDictionary *iconDict = @{@"Food":@"Food.png",@"Transportation":@"Transport.png", @"Education":@"Education.png", @"Clothing":@"Clothing.png",@"Housing":@"Housing.png",@"Other":@"Other.png"};
    [cell.typeImageView setImage:[UIImage imageNamed:[iconDict objectForKey:category]]];
    
    //get line view according to category
    NSDictionary *lineDict = @{@"Food":@"food_l.png",@"Transportation":@"transport_l.png", @"Education":@"education_l.png", @"Clothing":@"clothing_l.png",@"Housing":@"housing_l.png",@"Other":@"other_l.png"};
    [cell.lineImageView setImage:[UIImage imageNamed:[lineDict objectForKey:category]]];
    
    //date
    NSDate *date = transaction[@"date"];
    NSString *dateString = [self stringfromDateHelper:date];
    cell.dateLabel.text = dateString;
    
    
    //money
    NSNumber *amountt = transaction[@"amount"];
    int amount = [amountt intValue];
    cell.moneyLabel.text = [NSString stringWithFormat:@"$%i",amount];
    
    //title or memo
    cell.memoLabel.text = transaction[@"memo"];
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactions.count;
}

- (NSString *) stringfromDateHelper: (NSDate *) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd EEE hh:mm"];
    NSString *dateString = [dateFormatter stringFromDate:date];
    return dateString;
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
