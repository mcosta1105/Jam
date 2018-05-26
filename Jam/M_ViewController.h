//
//  M_ViewController.h
//  Jam
//
//  Created by Isabele Araujo on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "M_TableViewCell.h"
#import "Message.h"
#import "Gradients.h"

@interface M_ViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
{
    NSMutableArray * _data;
}
@property (weak, nonatomic) IBOutlet UIButton *sendBtn;
@property (weak, nonatomic) IBOutlet UITableView *messageTableView;
@end
