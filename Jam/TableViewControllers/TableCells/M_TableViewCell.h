//
//  M_TableViewCell.h
//  Jam
//
//  Created by 5661 on 25/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface M_TableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *receivedLabel;
@property (weak, nonatomic) IBOutlet UILabel *sentLabel;
@property (weak, nonatomic) IBOutlet UIView *receivedView;
@property (weak, nonatomic) IBOutlet UIView *sentView;

@end
