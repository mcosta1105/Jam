//
//  EditJamViewController.m
//  Jam
//
//  Created by Isabele Araujo on 26/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "EditJamViewController.h"

@interface EditJamViewController ()

@end

@implementation EditJamViewController
@synthesize updateBtn, deleteBtn, descriptionTextView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    
    descriptionTextView.layer.borderColor = [[UIColor colorWithRed:(200/255.0) green:(201/255.0) blue:(202/255.0) alpha:0.7]CGColor];
    descriptionTextView.layer.borderWidth = 1;
    descriptionTextView.layer.cornerRadius = 5;
    
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
    
    //Update Button gradient
    CAGradientLayer *updateBtnLayer = [Gradients blueBtnGradient];
    updateBtnLayer.frame = updateBtn.layer.bounds;
    updateBtnLayer.cornerRadius = updateBtn.layer.cornerRadius;
    [updateBtn.layer addSublayer:updateBtnLayer];
    
    //Delete Button gradient
    CAGradientLayer *deleteBtnLayer = [Gradients mainBtnGradient];
    deleteBtnLayer.frame = deleteBtn.layer.bounds;
    deleteBtnLayer.cornerRadius = deleteBtn.layer.cornerRadius;
    [deleteBtn.layer addSublayer:deleteBtnLayer];
}

@end
