//
//  RecordViewController.h
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "PostExpenseViewController.h"
#import "PostIncomeViewController.h"
#import "PostSaveViewController.h"

NS_ASSUME_NONNULL_BEGIN

@interface RecordViewController : UIViewController <UpdateTransactionDelegate,UpdateTransactionIDelegate,UpdateTransactionSDelegate>


@end

NS_ASSUME_NONNULL_END
