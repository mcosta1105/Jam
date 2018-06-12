//
//  ProfileViewController.m
//  Jam
//
//  Created by 5661 on 21/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "ProfileViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController
@synthesize profileImg, dataSegue, nameLabel, descriptionTextView, portfolioLable;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    [self configureView];
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
}

-(void)configureView{
    if (self.dataSegue) {
        nameLabel.text = dataSegue.name;
        descriptionTextView.text = dataSegue.userDescription;
        portfolioLable.text = dataSegue.portfolioLink;
    }
}

@end
