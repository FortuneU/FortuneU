//
//  SignupViewController.m
//  FortuneU
//
//  Created by User on 9/6/19.
//  Copyright © 2019 User. All rights reserved.
//

#import "SignupViewController.h"
#import <Parse/Parse.h>

@interface SignupViewController ()
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (strong, nonatomic) UIAlertController *alert;
@end

@implementation SignupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.alert = [UIAlertController alertControllerWithTitle:@"Error"
                                                     message:@"All fields should be non-empty!"
                                              preferredStyle:(UIAlertControllerStyleAlert)];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"OK"
                                                       style:UIAlertActionStyleDefault
                                                     handler:^(UIAlertAction * _Nonnull action) {
                                                         // handle response here.
                                                     }];
    // add the OK action to the alert controller
    [self.alert addAction:okAction];
}
- (IBAction)OnTapOutside:(id)sender {
    [self.view endEditing:YES];
}

- (IBAction)onTapSignUp:(id)sender {
    [self registerUser];
}
- (IBAction)OnTapLogIn:(id)sender {
    [self performSegueWithIdentifier:@"signuplogin" sender:nil];
}

- (void)registerUser {
    
    if ([self.usernameField.text isEqualToString:@""] || [self.passwordField.text isEqualToString:@""]) {
        [self presentViewController:self.alert animated:YES completion:^{
            // optional code for what happens after the alert controller has finished presenting
        }];
    }
    
    
    // initialize a user object
    PFUser *newUser = [PFUser user];
    
    // set user properties
    newUser.username = self.usernameField.text;
    
    newUser.password = self.passwordField.text;
    
    
    
    // call sign up function on the object
    [newUser signUpInBackgroundWithBlock:^(BOOL succeeded, NSError * error) {
        if (error != nil) {
            NSLog(@"Error: %@", error.localizedDescription);
        } else {
            NSLog(@"User registered successfully");
            PFUser *user = [PFUser currentUser];
            //user[@"profileImage"] = [Post getPFFileFromImage:[UIImage imageNamed:@"profilePlaceholder"] withName:@"profileImage"];
            //user[@"selfIntro"] = @"This user hasn't written anything yet.";
            //user[@"following"] = [[NSArray alloc] init];
            [user saveInBackground];
            //manually segue to logged in view
            [self performSegueWithIdentifier:@"signuplogin" sender:nil];
        }
    }];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
