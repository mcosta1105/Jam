//
//  MoreViewController.m
//  Jam
//
//  Created by 5661 on 26/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setGradients];
    // Do any additional setup after loading the view.
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

//Perform log out
- (IBAction)logOut:(id)sender {
    @try{
        NSError *error;
        BOOL status = [[FIRAuth auth] signOut:&error];
        
        if (!status) {
            AppAlerts *alert = [[AppAlerts alloc]init];
            [alert alertShowWithTitle:@"ERROR" andBody:[NSString stringWithFormat:@"IF"]];
            return;
        }else{
            [[FIRApp defaultApp]deleteApp:^(BOOL success) {
                if(success){
                    [self performSegueWithIdentifier:@"logOut" sender:nil];
                }
            }];
        }
    }
    @catch(NSException *ex){
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:@"ex"];
    }
}
@end
