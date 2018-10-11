//
//  ProfileViewController.h
//  Jam
//
//  Created by 5661 on 21/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"
#import "User.h"
#import "AppAlerts.h"
//Properties
@interface ProfileViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *profileImg;
@property (nonatomic) User *dataSegue;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UIButton *portfolioBtn;
@property (weak, nonatomic) IBOutlet UILabel *portfolioLable;
//Methods
- (IBAction)openPortfolio:(id)sender;
@end
