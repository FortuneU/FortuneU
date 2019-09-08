//
//  editGoalViewController.h
//  FortuneU
//
//  Created by User on 9/7/19.
//  Copyright © 2019 User. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol EditGoalDelegate;

@interface editGoalViewController : UIViewController
@property (strong,nonatomic) id<EditGoalDelegate> delegate;
@end

@protocol EditGoalDelegate
-(void) didEditGoal:(NSString *)name price:(NSString *)pString;
@end


NS_ASSUME_NONNULL_END
