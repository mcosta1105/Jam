//
//  AddJamViewController.h
//  Jam
//
//  Created by 5661 on 22/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Gradients.h"

@interface AddJamViewController : UIViewController<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *addBtn;

@end
