//
//  MyProfileViewController.m
//  Jam
//
//  Created by 5661 on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "MyProfileViewController.h"

@interface MyProfileViewController (){
    NSString* userId;
}

@end

@implementation MyProfileViewController
@synthesize changePicBtn, changePasswordBtn, saveBtn, descriptionTextView, nameTextField, emailTextField, passwordTextField, portfolioLink, loadingActivity, profileImage;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    [self setIcons];
    
    //Set text view placeholder
    self.descriptionTextView.delegate = self;
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

//Textview
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if ([textView.text isEqualToString:@"Description..."]) {
        textView.text = @"";
        textView.textColor = [UIColor lightGrayColor];
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

//get data to display on view
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
                        //Set object
                        [user setName: [firebaseData valueForKey:@"name"]];
                        [user setEmail: [firebaseData valueForKey:@"email"]];
                        [user setPortfolioLink: [firebaseData valueForKey:@"portfolio"]];
                        [user setUserDescription:[firebaseData valueForKey:@"description"]];
                        [user setImg: [firebaseData valueForKey:@"img"]];
                        
                        //Set image
                        if (![user.img isEqualToString:@""]) {
                            NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: user.img]];
                            [self.profileImage setImage:[UIImage imageWithData:imageData]];
                        }
                        //Set view
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
            //Prepare object
            User* user = [[User alloc]init];
            user.name = nameTextField.text;
            user.portfolioLink = portfolioLink.text;
            user.userDescription = descriptionTextView.text;
            user.email = emailTextField.text;
            
            if(userId == nil){
                userId = [FIRAuth auth].currentUser.uid;
            }
            
            AppData* database = [[AppData alloc]init];
            user.img = [database insertImg:profileImage];
            
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

//Change uer picture
- (IBAction)changePicture:(id)sender {
    @try{
            UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
        
            imagePicker.delegate = self;
        
            //Set Camera type for the source
            [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
            
            //Enable editing photo taken
            [imagePicker setAllowsEditing:YES];
            
            //Present Camera
            [self presentViewController:imagePicker animated:YES completion:nil];
       
    }
    @catch(NSException *ex){
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:ex.reason];
    }
}

//Pick image from device
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    @try{
        UIImage *image = info[UIImagePickerControllerEditedImage];
        [profileImage setImage:image];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    @catch(NSException *ex){
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:ex.reason];
    }
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    @try{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    @catch(NSException *ex){
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:ex.reason];
    }
}
@end
