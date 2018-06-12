//
//  EditJamViewController.h
//  Jam
//
//  Created by 5661 on 26/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"
#import "Post.h"

@interface EditJamViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextField *addressTextField;
@property (weak, nonatomic) IBOutlet UITextField *dateTextField;
@property (weak, nonatomic) IBOutlet UITextField *timeTextField;

@property (nonatomic)Post* dataSegue;
@end
