//
//  M_ViewController.m
//  Jam
//
//  Created by Isabele Araujo on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "M_ViewController.h"

@interface M_ViewController ()

@end

@implementation M_ViewController
@synthesize messageTableView;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    
    _data = [NSMutableArray array];
    
    NSInteger numberOfItems = 7;
    
    for(NSInteger i = 1; i <= numberOfItems; i++){
        Message *message = [[Message alloc]init];
        if (i%2 == 0) {
            message.text = @"Lorem ipsum dolor sit er elit lamet";
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
    
    [tableView registerNib:[UINib nibWithNibName:@"M_TableViewCell" bundle:nil] forCellReuseIdentifier:cellIdentifier];
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
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
