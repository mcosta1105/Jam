//
//  MyJamsTableViewController.m
//  Jam
//
//  Created by 5661 on 22/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "MyJamsTableViewController.h"

@interface MyJamsTableViewController ()

@end

@implementation MyJamsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _data = [NSMutableArray array];
    
    NSInteger numberOfItems = 5;
    
    for(NSInteger i = 1; i <= numberOfItems; i++){
        Post *myPost = [[Post alloc]init];
        myPost.title = @"I need a drummer urgent!";
        myPost.date = @"01/06/2018";
        myPost.time = @"18:00";
        myPost.address = @"7 Kelly Street, Ultimo NSW 2007";
        
        [_data addObject:myPost];
    }
    NSLog(@"%@", _data);
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}


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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
 [segue destinationViewController];
}

@end