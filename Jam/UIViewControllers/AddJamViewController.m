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
    descriptionTextView.textColor = [UIColor lightGrayColor];
    //descriptionTextView.textColor = mainColor;
    descriptionTextView.layer.borderColor = [[UIColor colorWithRed:(200/255.0) green:(201/255.0) blue:(202/255.0) alpha:0.7]CGColor];
    descriptionTextView.layer.borderWidth = 1;
    descriptionTextView.layer.cornerRadius = 5;
    
}


- (void)viewWillAppear:(BOOL)animated{
    self.loadingActivity.hidden = YES;
    [self.loadingActivity stopAnimating];
    
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
        textView.textColor = [UIColor lightGrayColor];
    }
    [textView resignFirstResponder];
}


- (IBAction)addJam:(id)sender {
    @try {
        self.loadingActivity.hidden = NO;
        [self.loadingActivity startAnimating];
        
        Post* post = [[Post alloc]init];
        
        post.title = self.titleTextField.text;
        post.date = self.dateTextField.text;
        post.time = self.timeTextField.text;
        post.address = self.addressTextField.text;
        post.postDescription = self.descriptionTextView.text;
        
        AppData* database = [[AppData alloc]init];
        [database insertPost:post];
        
        self.loadingActivity.hidden = YES;
        [self.loadingActivity stopAnimating];
        
        [self clearForm];
        
    } @catch (NSException *exception) {
        self.loadingActivity.hidden = YES;
        [self.loadingActivity stopAnimating];
        
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
}

//Cleans form after insert
-(void)clearForm{
    self.titleTextField.text = @"";
    self.timeTextField.text = @"";
    self.dateTextField.text = @"";
    self.descriptionTextView.text = @"";
    self.addressTextField.text = @"";
}
@end
