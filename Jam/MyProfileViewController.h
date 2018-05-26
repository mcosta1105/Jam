//
//  MyProfileViewController.h
//  Jam
//
//  Created by Isabele Araujo on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"

@interface MyProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UIButton *changePicBtn;
@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UITextField *emailTextField;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextField;
@property (weak, nonatomic) IBOutlet UIButton *changePasswordBtn;
@property (weak, nonatomic) IBOutlet UITextField *webLinkTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveBtn;

@end
