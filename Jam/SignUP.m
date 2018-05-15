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
    
    //Button gradient
    CAGradientLayer *btnGradientLayer = [Gradients mainBtnGradient];
    btnGradientLayer.frame = _signupBtn.layer.bounds;
    btnGradientLayer.cornerRadius = _signupBtn.layer.cornerRadius;
    [_signupBtn.layer addSublayer:btnGradientLayer];
    
    

}

@end
