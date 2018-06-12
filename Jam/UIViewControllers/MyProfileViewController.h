//
//  MyProfileViewController.h
//  Jam
//
//  Created by 5661 on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"
#import "InputIcons.h"
#import "AppData.h"
#import "User.h"
#import "AppAlerts.h"

@interface MyProfileViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIButton *changePicBtn;

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *changePasswordBtn;
@property (weak, nonatomic) IBOutlet UITextField *portfolioLink;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;


- (IBAction)save:(id)sender;
- (IBAction)changePassword:(id)sender;


@end
