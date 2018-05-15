//
//  InputIcons.m
//  Jam
//
//  Created by 5661 on 15/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "InputIcons.h"

@implementation InputIcons

-(void)setIcon:(NSString *)name forTextField:(UITextField *)textField{
    
    //Set frame
    UIImageView * icon = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    
    //Set icon
    [icon setImage:[UIImage imageNamed:name]];
    
    //Set content
    [icon setContentMode:UIViewContentModeScaleAspectFill];
    
    //Place icon on text field
    textField.leftView = icon;
    
    //Set display mode
    textField.leftViewMode = UITextFieldViewModeAlways;
    
    
}

@end
