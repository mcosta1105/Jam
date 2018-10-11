//
//  MyJamsTableViewController.h
//  Jam
//
//  Created by 5661 on 22/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Post.h"
#import "MyJamsTableViewCell.h"
#import "AppData.h"
@import Firebase;

@interface MyJamsTableViewController : UITableViewController
{
    NSMutableArray * _data;
}
@property (nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;
@property (strong, nonatomic) FIRDatabaseReference *ref;

@end
