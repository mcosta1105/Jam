//
//  MessageController.m
//  Jam
//
//  Created by 5661 on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "MessageController.h"

@interface MessageController ()

@end

@implementation MessageController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    _data = [NSMutableArray array];
    
    NSInteger numberOfItems = 7;
    
    for(NSInteger i = 1; i <= numberOfItems; i++){
        Message *message = [[Message alloc]init];
        if (i%2 == 0) {
            message.text = @"Velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident";
            message.sender = @"maycon";
            message.currentUser = @"maycon";
        }
        else{
            message.text = @"Lorem ipsum dolor sit er elit lamet";
            message.sender = @"peter";
            message.currentUser = @"peter";
        }
        [_data addObject:message];
    }
    NSLog(@"%@", _data);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_data count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"myCell";
    
    [self.tableView registerNib:[UINib nibWithNibName:@"M_TableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
    M_TableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    
    
    Message *item = [_data objectAtIndex:indexPath.row];
    if([[item sender] isEqualToString:@"maycon"]){
        cell.sentLabel.text = [item text];
        cell.receivedView.hidden = YES;
    }
    else{
        cell.receivedLabel.text = [item text];
        cell.sentLabel.hidden = YES;
    }
    
    return cell;
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
