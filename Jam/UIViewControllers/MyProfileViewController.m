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

@end
