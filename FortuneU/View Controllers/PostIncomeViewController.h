//
//  PostIncomeViewController.h
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UpdateTransactionIDelegate;

@interface PostIncomeViewController : UIViewController <SaveTransactionDelegate>
@property (nonatomic, strong) id<UpdateTransactionIDelegate> delegate2;
@end

@protocol UpdateTransactionIDelegate
-(void)updateRecord;
@end

NS_ASSUME_NONNULL_END
