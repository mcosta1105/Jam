//
//  EditJamViewController.h
//  Jam
//
//  Created by Isabele Araujo on 26/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"

@interface EditJamViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;
@property (weak, nonatomic) IBOutlet UIButton *deleteBtn;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;

@end
