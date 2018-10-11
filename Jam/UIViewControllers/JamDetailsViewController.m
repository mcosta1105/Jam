//
//  JamDetailsViewController.m
//  Jam
//
//  Created by 5661 on 21/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "JamDetailsViewController.h"
#import "ProfileViewController.h"

@interface JamDetailsViewController ()

@end

@implementation JamDetailsViewController
@synthesize messageBtn, dataSegue, nameLabel, addressLabel, dateLabel, timeLabel, titleLabel, descriptionTextView, user, profileBtn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    self.navigationController.navigationBarHidden = NO;
    
    
    [self getUser];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Set Gradients
-(void)setGradients{
    //background
    CAGradientLayer *background = [Gradients backgroundGradient];
    background.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:background atIndex:0];
    //message button
    CAGradientLayer *messageBtnLayer = [Gradients mainBtnGradient];
    messageBtnLayer.frame = messageBtn.layer.bounds;
    messageBtnLayer.cornerRadius = messageBtn.layer.cornerRadius;
    [messageBtn.layer addSublayer:messageBtnLayer];
}


-(void)configureView{
    if (self.dataSegue) {
        
        nameLabel.text = self.user.name;
        addressLabel.text = dataSegue.address;
        dateLabel.text = dataSegue.date;
        timeLabel.text = dataSegue.time;
        titleLabel.text = dataSegue.title;
        descriptionTextView.text = dataSegue.postDescription;
        NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: self.user.img]];
        [profileBtn setBackgroundImage:[UIImage imageWithData:imageData] forState:UIControlStateNormal];
        
        
    }
}


-(void)getUser{
    @try {
        AppData* data = [[AppData alloc]init];
        User* userData = [[User alloc]init];
        
        //Semaphore to execute async func
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        [[[[[data rootNode] child:@"users"] child:dataSegue.userId] child:@"profile"]
         observeSingleEventOfType:FIRDataEventTypeValue
         withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
             if (snapshot != nil) {
                 NSDictionary* firebaseData = snapshot.value;
                 
                 [userData setName: [firebaseData valueForKey:@"name"]];
                 [userData setEmail: [firebaseData valueForKey:@"email"]];
                 [userData setPortfolioLink: [firebaseData valueForKey:@"portfolio"]];
                 [userData setUserDescription: [firebaseData valueForKey:@"description"]];
                 [userData setImg: [firebaseData valueForKey:@"img"]];
                 
                 self.user = userData;
                 
                 //dispatch semaphore
                 dispatch_semaphore_signal(sema);
             }
         }withCancelBlock:^(NSError * _Nonnull error) {
             AppAlerts* alert = [[AppAlerts alloc]init];
             [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
         }];
        while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        }
    } @catch (NSException *exception) {
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
}

- (IBAction)viewProfile:(id)sender {
    [self performSegueWithIdentifier:@"toProfile" sender:self];
}

- (IBAction)contact:(id)sender {
    @try {
        //Construct mail compose view and set properties
        MFMailComposeViewController* mailComposer = [[MFMailComposeViewController alloc]init];
        mailComposer.mailComposeDelegate = self;
        
        //Check if is able to send email
        if ([MFMailComposeViewController canSendMail]) {
            [mailComposer setSubject:dataSegue.title];
            [mailComposer setToRecipients:@[user.email]];
            [self presentViewController:mailComposer animated:YES completion:nil];
        }
    } @catch (NSException *exception) {
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
}

-(void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    //Dismiss the mail composer view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}


//Set object on segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toProfile"])
    {
        ProfileViewController *viewController = segue.destinationViewController;
        viewController.dataSegue = self.user;
    }
}
@end
