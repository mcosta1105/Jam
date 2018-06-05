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
@synthesize emailTextField, passwordTextField, loginBtn, loadingActivity;

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

- (void)viewWillAppear:(BOOL)animated{
    //Hide Activity Indicator
    loadingActivity.hidden = YES;
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

//Login
- (IBAction)Login:(id)sender {
    @try {
        //Login form validation
        if([emailTextField.text isEqualToString:@""]){
            //Email input field required
            [self alertShowWithTitle:@"Empty Input Field" andBody:@"Please fill in email input field."];
        }
        else if ([passwordTextField.text isEqualToString:@""]){
            //Password input field required
            [self alertShowWithTitle:@"Empty Input Field" andBody:@"Please fill in password input field."];
        }
        else{
            //Show Activity Indicator
            loadingActivity.hidden = NO;
            [loadingActivity startAnimating];
            
            //Login
            [FIRAuth.auth signInWithEmail:emailTextField.text
                                 password:passwordTextField.text
                               completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                                   //Wait for firebase response to hide loading activity
                                   dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)),dispatch_get_main_queue(),
                                                  ^{
                                                      //Hide loading activity
                                                      self.loadingActivity.hidden = YES;
                                                      [self.loadingActivity stopAnimating];
                                   
                                                      if(authResult){
                                                          //Login successful
                                                          [self performSegueWithIdentifier:@"toJams" sender:self];
                                                      }
                                                      else{
                                                          //Did not login, display alert message to user
                                                          [self alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
                                                      }
                                                  });
            }];
        }
        
    } @catch (NSException *exception) {
        //Hide loading activity
        self.loadingActivity.hidden = YES;
        [self.loadingActivity stopAnimating];
        //Display error
        [self alertShowWithTitle:@"ERROR" andBody:[exception reason]];
    }
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

//Alert
-(void)alertShowWithTitle:(NSString *)titleInp andBody:(NSString *)bodyInp{
    UIAlertController* alert;
    alert = [UIAlertController alertControllerWithTitle:titleInp
                                                message:bodyInp
                                         preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
}

@end

