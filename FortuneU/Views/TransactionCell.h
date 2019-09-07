//
//  TransactionCell.h
//  FortuneU
//
//  Created by User on 9/7/19.
//  Copyright © 2019 User. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface TransactionCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *typeImageView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *memoLabel;
@property (weak, nonatomic) IBOutlet UIImageView *lineImageView;

@end

NS_ASSUME_NONNULL_END
