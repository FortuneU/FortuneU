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



@end

NS_ASSUME_NONNULL_END
