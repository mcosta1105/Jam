//
//  MyProfileViewController.m
//  Jam
//
//  Created by Isabele Araujo on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController (){
    NSString* userId;
}

@end

@implementation MyProfileViewController
@synthesize changePicBtn, changePasswordBtn, saveBtn, descriptionTextView, nameTextField, emailTextField, passwordTextField, portfolioLink, loadingActivity;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    [self setIcons];
    
    descriptionTextView.layer.borderColor = [[UIColor colorWithRed:(200/255.0) green:(201/255.0) blue:(202/255.0) alpha:0.7]CGColor];
    descriptionTextView.layer.borderWidth = 1;
    descriptionTextView.layer.cornerRadius = 5;
}


-(void)viewWillAppear:(BOOL)animated{
    [self loadData];
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
    
    //Save Button gradient
    CAGradientLayer *saveBtnLayer = [Gradients mainBtnGradient];
    saveBtnLayer.frame = saveBtn.layer.bounds;
    saveBtnLayer.cornerRadius = saveBtn.layer.cornerRadius;
    [saveBtn.layer addSublayer:saveBtnLayer];
}

//Set view Icons
-(void)setIcons{
    //Name
    InputIcons * name = [InputIcons alloc];
    [name setIcon:@"user" forTextField:nameTextField];
    //Password
    InputIcons * email = [InputIcons alloc];
    [email setIcon:@"email" forTextField:emailTextField];
    //Name
    InputIcons * password = [InputIcons alloc];
    [password setIcon:@"padlock" forTextField:passwordTextField];
    //Name
    InputIcons * web = [InputIcons alloc];
    [web setIcon:@"link" forTextField:portfolioLink];
}

-(void)loadData{
    @try {
        //Add loading activity
        [loadingActivity startAnimating];
        [loadingActivity setHidden:NO];
        
        AppData* data = [[AppData alloc]init];
        User* user = [[User alloc]init];
        
        if ([FIRAuth auth].currentUser != nil) {
            
                userId = [FIRAuth auth].currentUser.uid;
            
                [[[[[data rootNode] child:@"users"] child:userId] child:@"profile"]
                 observeSingleEventOfType:FIRDataEventTypeValue
                 withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
                    if (snapshot != nil) {
                        
                        
                        NSDictionary* firebaseData = snapshot.value;
                        
                        [user setName: [firebaseData valueForKey:@"name"]];
                        [user setEmail: [firebaseData valueForKey:@"email"]];
                        [user setPortfolioLink: [firebaseData valueForKey:@"portfolio"]];
                        [user setUserDescription:[firebaseData valueForKey:@"description"]];
                        
                        self.nameTextField.text = user.name;
                        self.emailTextField.text = user.email;
                        self.portfolioLink.text = user.portfolioLink;
                        self.descriptionTextView.text =  user.userDescription;
                        
                        //Stop and hide Activity Indicator
                        self.loadingActivity.hidden = YES;
                        [self.loadingActivity stopAnimating];
                    }
                }withCancelBlock:^(NSError * _Nonnull error) {
                    AppAlerts* alert = [[AppAlerts alloc]init];
                    [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
                }];
        }
        
    } @catch (NSException *exception) {
        //Display error
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    } 
}

//Save user profile to Firebase
- (IBAction)save:(id)sender {
    AppAlerts* alert = [[AppAlerts alloc]init];
    @try {
        //Validate text input fields
        if([self.nameTextField.text isEqualToString:@""]){
            [alert alertShowWithTitle:@"ERROR" andBody:@"Name"];
        }
        else if ([self.portfolioLink.text isEqualToString:@""]){
            [alert alertShowWithTitle:@"ERROR" andBody:@"Portfolio"];
        }
        else if ([self.descriptionTextView.text isEqualToString:@""]){
            [alert alertShowWithTitle:@"ERROR" andBody:@"Description"];
        }
        else{
            
            User* user = [[User alloc]init];
            user.name = nameTextField.text;
            user.portfolioLink = portfolioLink.text;
            user.userDescription = descriptionTextView.text;
            user.email = emailTextField.text;
            
            if(userId == nil){
                userId = [FIRAuth auth].currentUser.uid;
            }
            
            AppData* database = [[AppData alloc]init];
            [database updateUser:user withUserId:userId];
        }
    } @catch (NSException *exception) {
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
}


//Change user password
- (IBAction)changePassword:(id)sender {
    
    @try {
        UIAlertController *alert = [UIAlertController
                                    alertControllerWithTitle: @"Change Password"
                                    message:@"Enter a new password"
                                    preferredStyle:UIAlertControllerStyleAlert];
        
        //Add textfield
        [alert addTextFieldWithConfigurationHandler:^(UITextField *newPassword) {
            [newPassword setPlaceholder:@"New Password"];
            [newPassword setSecureTextEntry:YES];
            
        }];
        
        [alert addTextFieldWithConfigurationHandler:^(UITextField *confirmNewPassword) {
            [confirmNewPassword setPlaceholder:@"Confirm New Password"];
            [confirmNewPassword setSecureTextEntry:YES];
            
        }];
        
        //Buttons
        UIAlertAction *cancelButton = [UIAlertAction
                                       actionWithTitle: @"Cancel"
                                       style:UIAlertActionStyleCancel
                                       handler:^(UIAlertAction * _Nonnull action)
                                       {
                                           [alert dismissViewControllerAnimated:YES completion:nil];
                                       }];
        
        UIAlertAction *confirmButton = [UIAlertAction
                                        actionWithTitle: @"Confirm"
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * _Nonnull action){
                                            
                                            UITextField* newPwd = alert.textFields.firstObject;
                                            UITextField* confirmNewPwd = alert.textFields.lastObject;
                                            
                                            if([newPwd.text isEqualToString:@""]){
                                                //Display alert
                                                AppAlerts* alert = [[AppAlerts alloc]init];
                                                [alert alertShowWithTitle:@"ERROR" andBody:@"New password text field empty"];
                                            }else if ([confirmNewPwd.text isEqualToString:@""]){
                                                //Display alert
                                                AppAlerts* alert = [[AppAlerts alloc]init];
                                                [alert alertShowWithTitle:@"ERROR" andBody:@"Confirm new password text field empty"];
                                            }
                                            else if (![newPwd.text isEqualToString:confirmNewPwd.text]){
                                                //Display alert
                                                AppAlerts* alert = [[AppAlerts alloc]init];
                                                [alert alertShowWithTitle:@"ERROR" andBody:@"Confirm new password must be equal to new password"];
                                            }
                                            else{
                                                AppData* databse = [[AppData alloc]init];
                                                [databse changePassword:newPwd.text];
                                                AppAlerts* alert = [[AppAlerts alloc]init];
                                                [alert alertShowWithTitle:@"New Password" andBody:@"Nem password successfully changed"];
                                            }
                                        }];
        //Add Confirm button
        [alert addAction: confirmButton];
        [alert addAction: cancelButton];
        
        //Display Alert
        [self presentViewController:alert animated:YES completion:nil];
    } @catch (NSException *exception) {
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
    
}
@end
