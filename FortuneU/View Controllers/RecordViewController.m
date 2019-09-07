//
//  RecordViewController.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "RecordViewController.h"
#import "TransactionCell.h"

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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    TransactionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TaskCell"];
    
    if (!cell) {
        [tableView registerNib:[UINib nibWithNibName:@"TransactionCellView" bundle:nil] forCellReuseIdentifier:@"TransactionCell"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"TransactionCell"];
    }
    
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.transactions.count;
}



@end
