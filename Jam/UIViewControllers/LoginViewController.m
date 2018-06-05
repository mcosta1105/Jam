//
//  ViewController.m
//  Jam
//
//  Created by 5661 on 10/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
@synthesize emailTextField, passwordTextField, loginBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setGradients];
    [self setIcons];
    
    //Set Text Field Borders
    /*
    self.emailTextField.layer.borderColor = [[UIColor colorWithRed:(220/255.0) green:(65/255.0) blue:(141/255.0) alpha:1.0]CGColor];
    self.emailTextField.layer.backgroundColor = [[UIColor whiteColor] CGColor];
    self.emailTextField.layer.borderWidth = 1.0;
    self.emailTextField.layer.cornerRadius = 20.0;
    */
    
    [self firebaseTests];
}

-(void)firebaseTests{
    /*
    [FIRAuth.auth createUserWithEmail:@"maycon@maycon.com"
                             password:@"maycon1234"
                           completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error)
                                        {
                                            if(error == nil){
                                                [self alertShowWithTitle:@"Sucess!"
                                                                 andBody:@"You have succesfully made a new user!"];
                                            }
                                        }];
     */
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertShowWithTitle:(NSString *)titleInp andBody:(NSString *)bodyInp{
    UIAlertController* alert;
    alert = [UIAlertController alertControllerWithTitle:titleInp
                                                message:bodyInp
                                         preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok!" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
}



//Set view Gradients
-(void)setGradients{
    CAGradientLayer *gradientLayer = [Gradients backgroundGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    
    //login Button gradient
    CAGradientLayer *loginBtnLayer = [Gradients mainBtnGradient];
    loginBtnLayer.frame = loginBtn.layer.bounds;
    loginBtnLayer.cornerRadius = loginBtn.layer.cornerRadius;
    [loginBtn.layer addSublayer:loginBtnLayer];
    
}

//Set view Icons
-(void)setIcons{
    //Email
    InputIcons * email = [InputIcons alloc];
    [email setIcon:@"user" forTextField:emailTextField];
    //Password
    InputIcons * password = [InputIcons alloc];
    [password setIcon:@"padlock" forTextField:passwordTextField];
    
}


@end

