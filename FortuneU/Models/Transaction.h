//
//  Transaction.h
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//
#import <Parse/Parse.h>
#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Transaction : PFObject<PFSubclassing>

@property (strong,nonatomic) PFUser *user;
@property (strong,nonatomic) NSNumber *amount;
@property (strong,nonatomic) NSString *type;
@property (strong,nonatomic) NSDate *date;
@property (strong,nonatomic) NSString *memo;

+ (void) postTransactionWithAmount: (NSNumber * _Nullable) amount withType: (NSString * _Nullable )type withDate:(NSDate * _Nullable)date withMemo:(NSString * _Nullable)memo withCompletion: (PFBooleanResultBlock _Nullable) completion;

@end

NS_ASSUME_NONNULL_END
