//
//  Post.h
//  Jam
//
//  Created by 5661 on 17/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Post : NSObject
@property (weak, nonatomic) NSString *title;
@property (weak, nonatomic) NSString *address;
@property (weak, nonatomic) NSString *date;
@property (weak, nonatomic) NSString *time;
@property (weak, nonatomic) NSString *postDescription;
@end
