//
//  MyJamsTableViewController.m
//  Jam
//
//  Created by 5661 on 22/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "MyJamsTableViewController.h"
#import "EditJamViewController.h"
@interface MyJamsTableViewController (){
    NSString* userId;
}

@end

@implementation MyJamsTableViewController
@synthesize loadingActivity;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Prepare firebase
    self.ref = [[FIRDatabase database]reference];
    userId = [FIRAuth auth].currentUser.uid;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    //Set loading activity
    loadingActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingActivity.center = self.view.center;
    [self.tableView addSubview:loadingActivity];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [loadingActivity setHidesWhenStopped:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self prepareData];
    
    //Delay loading activity
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingActivity stopAnimating];
    });
    [self.tableView reloadData];
}

//Get data from firebase to set view
-(void)prepareData{
    //Start loading activity
    [self.loadingActivity startAnimating];
    
    //Firebase Query
    NSString* jamPostPath = [NSString stringWithFormat:@"data/posts"];
    
    //Query to get data from firebase
    FIRDatabaseQuery *query = [[[self.ref child:jamPostPath] queryOrderedByChild:@"uid"]queryEqualToValue:userId];
    
    _data = [[NSMutableArray alloc]init];
    
    //Get data from firebase and pass to object
    [query observeEventType:FIRDataEventTypeChildAdded withBlock:^(FIRDataSnapshot * _Nonnull snapshot) {
        Post* post = [[Post alloc]init];
        [post setTitle: [snapshot.value objectForKey:@"title"]];
        [post setDate: [snapshot.value objectForKey:@"date"]];
        [post setTime: [snapshot.value objectForKey:@"time"]];
        [post setAddress: [snapshot.value objectForKey:@"address"]];
        [post setPostDescription: [snapshot.value objectForKey:@"description"]];
        [post setUserId: [snapshot.value objectForKey:@"uid"]];
        [post setPostId: [snapshot.value objectForKey:@"id"]];
        
        [self->_data addObject:post];
        [self.tableView reloadData];
        
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self.loadingActivity stopAnimating];
        
    }withCancelBlock:^(NSError * _Nonnull error) {
        [self.loadingActivity stopAnimating];
        
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
    }];
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}

//Set data to cells
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 static NSString *cellIdentifier = @"myCell";
    
     [self.tableView registerNib:[UINib nibWithNibName:@"MyJamsTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    
     MyJamsTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
     Post *item = [_data objectAtIndex:indexPath.row];
     cell.postTitleLabel.text = [item title];
     cell.timeLabel.text = [item time];
     cell.addressLabel.text = [item address];
     cell.dateLabel.text = [item date];
 
 return  cell;
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toEditJam" sender:self];
}

//Get data from cell and set on segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //check if segue is correct
    if ([segue.identifier isEqualToString:@"toEditJam"])
    {
        Post *post = [_data objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        EditJamViewController *viewController = segue.destinationViewController;
        viewController.dataSegue = post;
    }
}



@end
