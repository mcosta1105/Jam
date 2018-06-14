//
//  SearchTableViewController.m
//  Jam
//
//  Created by 5661 on 17/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "SearchTableViewController.h"
#import "JamDetailsViewController.h"

@interface SearchTableViewController (){
    NSString* userId;
}
@end
@implementation SearchTableViewController
@synthesize  loadingActivity;
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.ref = [[FIRDatabase database]reference];
    userId = [FIRAuth auth].currentUser.uid;
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    
    loadingActivity = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    loadingActivity.center = self.view.center;
    [self.tableView addSubview:loadingActivity];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [loadingActivity setHidesWhenStopped:YES];
    
    
}
/*
-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self prepareData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingActivity stopAnimating];
    });
}
 */
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self prepareData];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.loadingActivity stopAnimating];
    });
    [self.tableView reloadData];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
-(void)prepareData{
    [loadingActivity startAnimating];
    
    //Firebase Query
    NSString* jamPostPath = [NSString stringWithFormat:@"data/posts"];
    
    FIRDatabaseQuery *query = [[self.ref child:jamPostPath] queryOrderedByKey];
    
    _data = [[NSMutableArray alloc]init];
    
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"myCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    
    Post *item = [_data objectAtIndex:indexPath.row];
    cell.titleLabel.text = [item title];
    cell.timeLabel.text = [item time];
    cell.addressLabel.text = [item address];
    cell.dateLabel.text = [item date];
    
    return  cell;
    
}

//click on cell

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toJamDetails" sender:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"toJamDetails"])
    {
        Post *post = [_data objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        JamDetailsViewController *viewController = segue.destinationViewController;
        viewController.dataSegue = post;
    }
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation
/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
        [segue destinationViewController];
    // Pass the selected object to the new view controller.
}
*/
@end
