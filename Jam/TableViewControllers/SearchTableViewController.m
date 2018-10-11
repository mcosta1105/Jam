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
    NSMutableArray* filteredPosts;
    BOOL isFiltered;
}
@end
@implementation SearchTableViewController
@synthesize  loadingActivity;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Prepare searchbar
    isFiltered = false;
    self.searchBar.delegate = self;
    
    //Prepare firebase authentication
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

//Searchbar implementation
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    //check is serachbar is empty
    if (searchText.length == 0) {
        isFiltered = false;
    }
    else{
        //If not take input and perform search
        isFiltered = true;
        filteredPosts = [[NSMutableArray alloc]init];
        for (Post* post in _data) {
            NSRange titleRange = [post.title rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange descriptionRange = [post.postDescription rangeOfString:searchText options:NSCaseInsensitiveSearch];
            NSRange addressRange = [post.address rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (titleRange.location != NSNotFound) {
                [filteredPosts addObject:post];
            }
            else if (descriptionRange.location != NSNotFound){
                [filteredPosts addObject:post];
            }
            else if (addressRange.location != NSNotFound){
                [filteredPosts addObject:post];
            }
        }
    }
    [self.tableView reloadData];
}




//Prepare data for view
-(void)prepareData{
    [loadingActivity startAnimating];
    
    //Firebase Query
    NSString* jamPostPath = [NSString stringWithFormat:@"data/posts"];
    
    FIRDatabaseQuery *query = [[self.ref child:jamPostPath] queryOrderedByKey];
    
    _data = [[NSMutableArray alloc]init];
    
    //Get data from firebase
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
    if (isFiltered) {
        return [filteredPosts count];
    }
    return [_data count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"myCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"SearchTableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    SearchTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    if (isFiltered) {
        Post *item = [filteredPosts objectAtIndex:indexPath.row];
        cell.titleLabel.text = [item title];
        cell.timeLabel.text = [item time];
        cell.addressLabel.text = [item address];
        cell.dateLabel.text = [item date];
    }
    else{
        Post *item = [_data objectAtIndex:indexPath.row];
        cell.titleLabel.text = [item title];
        cell.timeLabel.text = [item time];
        cell.addressLabel.text = [item address];
        cell.dateLabel.text = [item date];
    }
    
    return  cell;
    
}

//click on cell

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self performSegueWithIdentifier:@"toJamDetails" sender:self];
}

//Take cell value and set on segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    //check if segue is correct
    if ([segue.identifier isEqualToString:@"toJamDetails"])
    {
        Post *post = [[Post alloc]init];
        //Check if list has been filtered
        if (isFiltered) {
            post = [filteredPosts objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        }
        else{
            post = [_data objectAtIndex:self.tableView.indexPathForSelectedRow.row];
        }
        JamDetailsViewController *viewController = segue.destinationViewController;
        viewController.dataSegue = post;
    }
}


@end
