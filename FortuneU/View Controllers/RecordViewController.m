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
#import "PostViewController.h"

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
    self.tableView.rowHeight = 80;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self getTransactions];
}
- (IBAction)onTapPlusButton:(id)sender {
    [self performSegueWithIdentifier:@"compose" sender:nil];
    
}

- (void) getTransactions {
    
    PFQuery *query = [PFQuery queryWithClassName:@"Transaction"];
    [query orderByDescending:@"date"];
    [query includeKey:@"user"];
    [query includeKey:@"memo"];
    [query includeKey:@"amount"];
    [query includeKey:@"type"];
    [query whereKey:@"user" equalTo:[PFUser currentUser]];
    
    
    // fetch data asynchronously
    [query findObjectsInBackgroundWithBlock:^(NSArray *transactions, NSError *error) {
        if (transactions != nil) {
            // do something with the array of object returned by the call
            //self.transactions = [transactions mutableCopy];
            self.transactions = transactions;
            //self.filteredData = self.transactions;
            [self.tableView reloadData];
            //[self.refreshControl endRefreshing];
            //[self.activityIndicator stopAnimating];
            
        } else {
            NSLog(@"%@", error.localizedDescription);
            UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Network failure."
                                                                           message:@"Please check your network connection."
                                                                    preferredStyle:(UIAlertControllerStyleAlert)];
            
            // create an OK action
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
        
    }];
    
}


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TransactionCell" bundle:nil] forCellReuseIdentifier:@"TransactionCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionCell"];
    }
    
    Transaction *transaction = self.transactions[indexPath.row];
    NSString *category = transaction[@"type"];
    
    //get icon view according to category
    NSDictionary *iconDict = @{@"Food":@"Food.png",@"Transportation":@"Transport.png", @"Education":@"Education.png", @"Clothing":@"Clothing.png",@"Housing":@"Housing.png",@"Other":@"Other.png",
                               @"Salary":@"salary.png", @"Scholarship":@"scholarship.png", @"Reimbursement":@"reimburse.png", @"Investment":@"invest.png",@"OtherI":@"otheri.png"
                               };
    [cell.typeImageView setImage:[UIImage imageNamed:[iconDict objectForKey:category]]];
    
    //get line view according to category
    NSDictionary *lineDict = @{@"Food":@"food_l.png",@"Transportation":@"transport_l.png", @"Education":@"education_l.png", @"Clothing":@"clothing_l.png",@"Housing":@"housing_l.png",@"Other":@"other_l.png",
                               @"Salary":@"salary_l.png", @"Scholarship":@"scholarship_l.png",@"Reimbursement":@"reimbursement_l.png", @"Investment":@"invest_l.png", @"OtherI":@"otheri_l.png"
                               };
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



 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
     if ([[segue identifier] isEqualToString:@"compose"]) {
         UINavigationController *nvc = (UINavigationController*) [segue destinationViewController];
         PostViewController *vc = (PostViewController*) nvc.topViewController;
         vc.pre = self;
         vc.preI = self;
         vc.preS = self;
         //PostExpenseViewController *vce = [self.storyboard instantiateViewControllerWithIdentifier:@"postexpense"];
         //vce.delegate2 = self;
     }
 }





- (void)updateRecord {
    [self getTransactions];
    //[self.tableView reloadData];
}



@end
