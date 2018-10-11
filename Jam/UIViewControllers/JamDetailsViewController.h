//
//  JamDetailsViewController.h
//  Jam
//
//  Created by 5661 on 21/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"
#import "Post.h"
#import "AppData.h"
#import "User.h"
#import <MessageUI/MessageUI.h>

@interface JamDetailsViewController : UIViewController<MFMailComposeViewControllerDelegate>
//Properties
@property (weak, nonatomic) IBOutlet UIButton *messageBtn;
@property (weak, nonatomic) IBOutlet UIButton *profileBtn;
@property (nonatomic) Post *dataSegue;
@property (nonatomic) User *user;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
//Methods
- (IBAction)viewProfile:(id)sender;
- (IBAction)contact:(id)sender;

@end
