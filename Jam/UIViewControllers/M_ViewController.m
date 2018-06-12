//
//  M_ViewController.m
//  Jam
//
//  Created by 5661 on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "M_ViewController.h"

@interface M_ViewController ()

@end

@implementation M_ViewController
@synthesize messageTableView, sendBtn;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setGradients];
    self.messageTableView.delegate = self;
    self.messageTableView.dataSource = self;
    
    
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

//Set view Gradients
-(void)setGradients{
    CAGradientLayer *gradientLayer = [Gradients backgroundGradient];
    gradientLayer.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [self.view.layer insertSublayer:gradientLayer atIndex:0];
    
    
    //login Button gradient
    CAGradientLayer *sendBtnLayer = [Gradients mainBtnGradient];
    sendBtnLayer.frame = sendBtn.layer.bounds;
    sendBtnLayer.cornerRadius = sendBtn.layer.cornerRadius;
    [sendBtn.layer addSublayer:sendBtnLayer];
    
}


@end
