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
@property (nonatomic,weak) id<SaveTransactionDelegate> delegateI;
@property (nonatomic,weak) id<SaveTransactionDelegate> delegateS;

@property (nonatomic,weak) UIViewController *pre;
@property (nonatomic,weak) UIViewController *preI;
@property (nonatomic,weak) UIViewController *preS;


@end





NS_ASSUME_NONNULL_END
