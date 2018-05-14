//
//  ViewController.m
//  Jam
//
//  Created by 5661 on 10/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setGradients];
    
    
    UIImageView *userIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    [userIcon setImage:[UIImage imageNamed:@"userIcon"]];
    
    [userIcon setContentMode:UIViewContentModeScaleAspectFill];
    self.emailTextField.leftView = userIcon;
    self.emailTextField.leftViewMode = UITextFieldViewModeAlways;
    
    UIImageView *padLockIcon = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 25, 25)];
    [padLockIcon setImage:[UIImage imageNamed:@"padlock"]];
    
    [padLockIcon setContentMode:UIViewContentModeScaleAspectFill];
    self.passwordTextField.leftView = padLockIcon;
    self.passwordTextField.leftViewMode =UITextFieldViewModeAlways;
    
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setGradients{
    CAGradientLayer *gradientLayer = [Gradients backgroundGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}



@end

