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
@synthesize signupBtn, cancelBtn, nameTextField, emailTextField, passwordTextField, confirmPasswordTextField ;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    [self setIcons];
    self.termsSwitch.transform = CGAffineTransformMakeScale(0.8, 0.8);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

@end
