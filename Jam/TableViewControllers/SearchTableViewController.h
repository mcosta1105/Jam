//
//  SearchTableViewController.h
//  Jam
//
//  Created by 5661 on 17/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SearchTableViewCell.h"
#import "Post.h"
#import "AppData.h"

@import Firebase;


@interface SearchTableViewController : UITableViewController
{
    NSMutableArray * _data;
}

@property (nonatomic) IBOutlet UIActivityIndicatorView *loadingActivity;

@property (strong, nonatomic) FIRDatabaseReference *ref;
@end
