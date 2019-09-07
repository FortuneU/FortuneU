//
//  Transaction.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "Transaction.h"
#import "Parse/Parse.h"

@implementation Transaction

@dynamic user;
@dynamic amount;
@dynamic type;
@dynamic date;
@dynamic memo;

+(nonnull NSString*) parseClassName {
    return @"Transaction";
}

+ (void) postTransactionWithAmount: (NSNumber * _Nullable) amount withType: (NSString * _Nullable )type withDate:(NSDate * _Nullable)date withMemo:(NSString * _Nullable)memo withCompletion: (PFBooleanResultBlock _Nullable) completion{
    Transaction *newTransaction = [Transaction new];
    newTransaction.user = [PFUser currentUser];
    newTransaction.amount = amount;
    newTransaction.type = type;
    newTransaction.date = date;
    
    [newTransaction saveInBackgroundWithBlock:completion];
}

@end
