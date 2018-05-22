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
@synthesize descriptionTextView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.descriptionTextView.delegate = self;
    descriptionTextView.text =@"Description...";
    descriptionTextView.textColor = [UIColor colorWithRed:(213/255.0) green:(67/255.0) blue:(147/255.0) alpha:1.0];
    
    
    
    descriptionTextView.layer.borderColor = [[UIColor colorWithRed:(200/255.0) green:(201/255.0) blue:(202/255.0) alpha:0.7]CGColor];
    descriptionTextView.layer.borderWidth = 1;
    descriptionTextView.layer.cornerRadius = 5;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
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
