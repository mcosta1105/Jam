//
//  SignUP.m
//  Jam
//
//  Created by 5661 on 15/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "SignUP.h"

@interface SignUP ()

@end

@implementation SignUP
@synthesize signupBtn, cancelBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
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

@end
