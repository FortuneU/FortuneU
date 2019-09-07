//
//  PostSaveViewController.h
//  FortuneU
//
//  Created by User on 9/7/19.
//  Copyright © 2019 User. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostViewController.h"

NS_ASSUME_NONNULL_BEGIN

@protocol UpdateTransactionSDelegate;


@interface PostSaveViewController : UIViewController <SaveTransactionDelegate>
@property (nonatomic, strong) id<UpdateTransactionSDelegate> delegate2;
@end

@protocol UpdateTransactionSDelegate
-(void)updateRecord;
@end


NS_ASSUME_NONNULL_END
