//
//  TermsViewController.m
//  Jam
//
//  Created by Isabele Araujo on 26/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "TermsViewController.h"

@interface TermsViewController ()

@end

@implementation TermsViewController
@synthesize cancelBtn, acceptBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setGradients{
    //Background gradient
    CAGradientLayer *gradientLayer = [Gradients backgroundGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    //Cancel Button gradient
    CAGradientLayer *cancelBtnLayer = [Gradients blueBtnGradient];
    cancelBtnLayer.frame = cancelBtn.layer.bounds;
    cancelBtnLayer.cornerRadius = cancelBtn.layer.cornerRadius;
    [cancelBtn.layer addSublayer:cancelBtnLayer];
    
    //Accept Button gradient
    CAGradientLayer *acceptBtnLayer = [Gradients mainBtnGradient];
    acceptBtnLayer.frame = acceptBtn.layer.bounds;
    acceptBtnLayer.cornerRadius = acceptBtn.layer.cornerRadius;
    [acceptBtn.layer addSublayer:acceptBtnLayer];
}
@end
