//
//  AddJamViewController.h
//  Jam
//
//  Created by 5661 on 22/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"
#import "AppData.h"
#import "AppAlerts.h"
#import "Post.h"

@interface AddJamViewController : UIViewController<UITextViewDelegate, UITextFieldDelegate>
//Properties
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;
//Methods
- (IBAction)addJam:(id)sender;

@end
