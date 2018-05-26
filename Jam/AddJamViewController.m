//
//  AddJamViewController.m
//  Jam
//
//  Created by 5661 on 22/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "AddJamViewController.h"

@interface AddJamViewController ()

@end

@implementation AddJamViewController
@synthesize descriptionTextView, addBtn, timeTextField, titleTextField, addressTextField, dateTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setGradients];
    
    self.descriptionTextView.delegate = self;
    
    descriptionTextView.text =@"Description...";
    descriptionTextView.textColor = [UIColor colorWithRed:(213/255.0) green:(67/255.0) blue:(147/255.0) alpha:1.0];
    //descriptionTextView.textColor = mainColor;
    descriptionTextView.layer.borderColor = [[UIColor colorWithRed:(200/255.0) green:(201/255.0) blue:(202/255.0) alpha:0.7]CGColor];
    descriptionTextView.layer.borderWidth = 1;
    descriptionTextView.layer.cornerRadius = 5;
    
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
    
    
    
    
    //Add Button gradient
    CAGradientLayer *addtBtnLayer = [Gradients mainBtnGradient];
    addtBtnLayer.frame = addBtn.layer.bounds;
    addtBtnLayer.cornerRadius = addBtn.layer.cornerRadius;
    [addBtn.layer addSublayer:addtBtnLayer];
}


- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Description..."]) {
        textView.text = @"";
        textView.textColor = [UIColor darkGrayColor];
    }
    [textView becomeFirstResponder];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@""]) {
        textView.text = @"Description...";
        textView.textColor = [UIColor colorWithRed:(213/255.0) green:(67/255.0) blue:(147/255.0) alpha:1.0];
    }
    [textView resignFirstResponder];
}

@end
