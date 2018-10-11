//
//  AppAlerts.m
//  Jam
//
//  Created by 5661 on 5/6/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "AppAlerts.h"

@interface AppAlerts ()

@end

@implementation AppAlerts

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIViewController *)topViewController {
    return [self topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

//Get current view controller
- (UIViewController *)topViewController:(UIViewController *)rootViewController {
    
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [self topViewController:lastViewController];
    }
    
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [self topViewController:presentedViewController];
}


//Alert with title
-(void)alertShowWithTitle:(NSString *)title andBody:(NSString *)message{
    UIAlertController* alert;
    alert = [UIAlertController alertControllerWithTitle:title
                                                message:message
                                         preferredStyle:UIAlertControllerStyleAlert];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
    
    [self presentViewController:alert animated:true completion:nil];
    
    //Display Alert
    UIViewController *rootViewController = self.topViewController;
    [rootViewController presentViewController:alert animated:YES completion:nil];
}


@end
