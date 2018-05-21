//
//  JamDetailsViewController.m
//  Jam
//
//  Created by 5661 on 21/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "JamDetailsViewController.h"

@interface JamDetailsViewController ()

@end

@implementation JamDetailsViewController
@synthesize messageBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Set Gradients
-(void)setGradients{
    //background
    CAGradientLayer *background = [Gradients backgroundGradient];
    background.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:background atIndex:0];
    //message button
    CAGradientLayer *messageBtnLayer = [Gradients mainBtnGradient];
    messageBtnLayer.frame = messageBtn.layer.bounds;
    messageBtnLayer.cornerRadius = messageBtn.layer.cornerRadius;
    [messageBtn.layer addSublayer:messageBtnLayer];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
