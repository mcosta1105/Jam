//
//  EditJamViewController.m
//  Jam
//
//  Created by 5661 on 26/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "EditJamViewController.h"

@interface EditJamViewController ()

@end

@implementation EditJamViewController
@synthesize updateBtn, deleteBtn, descriptionTextView, dataSegue, titleTextField, timeTextField, addressTextField, dateTextField;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    
    //Set textview placeholder
    descriptionTextView.layer.borderColor = [[UIColor colorWithRed:(200/255.0) green:(201/255.0) blue:(202/255.0) alpha:0.7]CGColor];
    descriptionTextView.layer.borderWidth = 1;
    descriptionTextView.layer.cornerRadius = 5;
    descriptionTextView.textColor = [UIColor darkGrayColor];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self configureView];
    UIDatePicker *datePicker = [[UIDatePicker alloc]init];
    [datePicker setDate:[NSDate date]];
    [datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
    [self.dateTextField setInputView:datePicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Updates textfield with picker value
-(void)updateTextField:(id)sender
{
    UIDatePicker *picker = (UIDatePicker*)self.dateTextField.inputView;
    self.dateTextField.text = [NSString stringWithFormat:@"%@",[self formatDate:picker.date]];
}


//Formate input date
- (NSString *)formatDate:(NSDate *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"dd'/'MM'/'yyyy"];
    NSString *formattedDate = [dateFormatter stringFromDate:date];
    return formattedDate;
}

-(void)setGradients{
    //Background gradient
    CAGradientLayer *gradientLayer = [Gradients backgroundGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    //Update Button gradient
    CAGradientLayer *updateBtnLayer = [Gradients mainBtnGradient];
    updateBtnLayer.frame = updateBtn.layer.bounds;
    updateBtnLayer.cornerRadius = updateBtn.layer.cornerRadius;
    [updateBtn.layer addSublayer:updateBtnLayer];
    
    //Delete Button gradient
    CAGradientLayer *deleteBtnLayer = [Gradients blueBtnGradient];
    deleteBtnLayer.frame = deleteBtn.layer.bounds;
    deleteBtnLayer.cornerRadius = deleteBtn.layer.cornerRadius;
    [deleteBtn.layer addSublayer:deleteBtnLayer];
}


//set view up
- (void)configureView {
    if(self.dataSegue) {
        titleTextField.text = dataSegue.title;
        descriptionTextView.text = dataSegue.postDescription;
        timeTextField.text = dataSegue.time;
        dateTextField.text = dataSegue.date;
        addressTextField.text = dataSegue.address;
    }
}

//Update jam post
- (IBAction)updatePost:(id)sender {
    Post* post = [[Post alloc]init];
    
    post.postId = dataSegue.postId;
    post.userId = dataSegue.userId;
    post.title = titleTextField.text;
    post.postDescription = descriptionTextView.text;
    post.date = dateTextField.text;
    post.time = timeTextField.text;
    post.address = addressTextField.text;
    
    AppData* database = [[AppData alloc]init];
    [database updatePost:post];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//Delete Jam Post
- (IBAction)deletePost:(id)sender {
    AppData* database = [[AppData alloc]init];
    [database deletePost:dataSegue];
    [self.navigationController popViewControllerAnimated:YES];
}
@end
