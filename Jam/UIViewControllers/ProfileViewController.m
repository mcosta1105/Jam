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
@synthesize profileImg, dataSegue, nameLabel, descriptionTextView, portfolioBtn, portfolioLable;

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

//Set background gradients
-(void)setGradients{
    //Background gradient
    CAGradientLayer *gradientLayer = [Gradients backgroundGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
}

//Set data to view
-(void)configureView{
    if (self.dataSegue) {
        nameLabel.text = dataSegue.name;
        descriptionTextView.text = dataSegue.userDescription;
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: dataSegue.img]];
        [profileImg setImage:[UIImage imageWithData:imageData]];
        [portfolioBtn setTitle:dataSegue.portfolioLink forState:UIControlStateNormal];
    }
}

//Open external link
- (IBAction)openPortfolio:(id)sender {
    @try {
        UIApplication *application = [UIApplication sharedApplication];
        NSURL *URL = [[NSURL alloc]init];
        
        //Check if porftolio link has https://
        NSRange range = [dataSegue.portfolioLink rangeOfString:@"https://" options:NSCaseInsensitiveSearch];
        if (range.location != NSNotFound) {
            URL = [NSURL URLWithString:dataSegue.portfolioLink];
        }
        else{
            //if not, add it
            URL = [NSURL URLWithString:[NSString stringWithFormat:@"https://%@",dataSegue.portfolioLink]];
        }
        
        [application openURL:URL options:@{} completionHandler:nil];
    } @catch (NSException *exception) {
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
}
@end
