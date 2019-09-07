//
//  PostViewController.h
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import <UIKit/UIKit.h>



NS_ASSUME_NONNULL_BEGIN




@protocol SaveTransactionDelegate
-(void)onTapSave;
@end

@interface PostViewController : UIViewController

@property (nonatomic,weak) id<SaveTransactionDelegate> delegate;

@property (nonatomic,weak) UIViewController *pre;


@end





NS_ASSUME_NONNULL_END
