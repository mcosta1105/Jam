//
//  SignUP.m
//  Jam
//
//  Created by 5661 on 15/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "SignUPViewController.h"

@interface SignUPViewController ()

@end

@implementation SignUPViewController
@synthesize signupBtn, cancelBtn, nameTextField, emailTextField, passwordTextField, confirmPasswordTextField, loadingActivity, termsSwitch ;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view
    
    
    [self setGradients];
    [self setIcons];
    self.termsSwitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    //Hide Activity Indicator
    loadingActivity.hidden = YES;
    [termsSwitch setOn:false];
 }

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(void)setGradients{
    //Background gradient
    CAGradientLayer *gradientLayer = [Gradients backgroundGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    //SignUp Button gradient
    CAGradientLayer *signUpBtnLayer = [Gradients mainBtnGradient];
    signUpBtnLayer.frame = signupBtn.layer.bounds;
    signUpBtnLayer.cornerRadius = signupBtn.layer.cornerRadius;
    [signupBtn.layer addSublayer:signUpBtnLayer];
    
    //Cancel Button gradient
    CAGradientLayer * cancelBtnLayer = [Gradients blueBtnGradient];
    cancelBtnLayer.frame = cancelBtn.layer.bounds;
    cancelBtnLayer.cornerRadius = cancelBtn.layer.cornerRadius;
    [cancelBtn.layer addSublayer:cancelBtnLayer];

}

-(void)setIcons{
    //name
    InputIcons * name = [InputIcons alloc];
    [name setIcon:@"user" forTextField:nameTextField];
    
    InputIcons * email = [InputIcons alloc];
    [email setIcon:@"email" forTextField:emailTextField];
    
    InputIcons * password = [InputIcons alloc];
    [password setIcon:@"padlock" forTextField:passwordTextField];
    
    InputIcons * confirm = [InputIcons alloc];
    [confirm setIcon:@"padlock" forTextField:confirmPasswordTextField];
}

//Sign Up
- (IBAction)SignUp:(id)sender {
    
    @try {
        if ([termsSwitch isOn]) {
            if ([nameTextField.text isEqualToString:@""]) {
                //Name input field required
                [self alertShowWithTitle:@"Empty Input Field" andBody:@"Please fill in name input field."];
            }
            else if ([emailTextField.text isEqualToString:@""]){
                //Email input field required
                [self alertShowWithTitle:@"Empty Input Field" andBody:@"Please fill in email input field."];
            }
            else if ([passwordTextField.text isEqualToString:@""]){
                //Password input field required
                [self alertShowWithTitle:@"Empty Input Field" andBody:@"Please fill in password input field."];
            }
            else if ([confirmPasswordTextField.text isEqualToString:@""]){
                //Confirm password input field required
                [self alertShowWithTitle:@"Empty Input Field" andBody:@"Please fill in confirm password input field."];
            }
            else if (![passwordTextField.text isEqualToString:confirmPasswordTextField.text]){
                //Password does not match
                [self alertShowWithTitle:@"Error" andBody:@"Confirm password does not match password."];
            }
            else{
                //Show Activity Indicator
                loadingActivity.hidden = NO;
                [loadingActivity startAnimating];
                
                User* user = [[User alloc]init];
                user.name = nameTextField.text;
                user.email = emailTextField.text;
                user.userDescription = @"Add description about yourself";
                user.portfolioLink = @"Add portfolio link";
                
                [FIRAuth.auth createUserWithEmail:emailTextField.text
                                         password:passwordTextField.text
                                       completion:^(FIRAuthDataResult * _Nullable authResult, NSError * _Nullable error) {
                                           if(authResult != nil){
                                               NSString* userId;
                                               userId = [FIRAuth auth].currentUser.uid;
                                               @try {
                                                   AppData* data = [[AppData alloc]init];
                                                   [data insertUser:user withUserId:userId];
                                                   [self performSegueWithIdentifier:@"toHome" sender:self];
                                               } @catch (NSException *exception) {
                                                   [self alertShowWithTitle:@"Error" andBody:exception.reason];
                                               }
                                           }
                                           else{
                                               //Hide loading activity
                                               self.loadingActivity.hidden = YES;
                                               [self.loadingActivity stopAnimating];
                                               [self alertShowWithTitle:@"Error" andBody:error.localizedDescription];
                                           }
                                           
                                        }
                 ];
            }
        }
        else{
            
            //Display error
            [self alertShowWithTitle:@"ERROR" andBody:@"You did not accept Terms and Conditions"];
        }
        
    } @catch (NSException *exception) {
        //Hide loading activity
        self.loadingActivity.hidden = YES;
        [self.loadingActivity stopAnimating];
        //Display error
        [self alertShowWithTitle:@"ERROR" andBody:[exception reason]];
    }
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
