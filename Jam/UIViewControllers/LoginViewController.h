//
//  ViewController.h
//  Jam
//
//  Created by 5661 on 10/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"
#import "InputIcons.h"
#import "AppAlerts.h"

@import Firebase;

@interface LoginViewController : UIViewController
//Properties
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;
//Methods
- (IBAction)Login:(id)sender;



@end
