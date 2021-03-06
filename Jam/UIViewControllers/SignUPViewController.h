//
//  SignUP.h
//  Jam
//
//  Created by 5661 on 15/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"
#import "InputIcons.h"
#import "User.h"
#import "AppData.h"
#import "AppAlerts.h"

@import Firebase;

@interface SignUPViewController : UIViewController


//Properties
@property (weak, nonatomic) IBOutlet UIButton *signupBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UITextField *confirmPasswordTextField;
@property (weak, nonatomic) IBOutlet UISwitch *termsSwitch;

//Methods
- (IBAction)SignUp:(id)sender;
-(void)alertShowWithTitle:(NSString *)titleInp andBody:(NSString *)bodyInp;

@end
