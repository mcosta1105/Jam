//
//  AppData.h
//  Jam
//
//  Created by 5661 on 5/6/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase.h>
#import "User.h"
#import "Post.h"
#import "AppAlerts.h"

@interface AppData : NSObject

@property (nonatomic) FIRDatabaseReference * rootNode;
@property (nonatomic) FIRDatabaseReference * dataNode;
@property (nonatomic) FIRDatabaseReference * usersNode;

@property NSString *USER_ID;

-(void)insertUser:(User *)user withUserId:(NSString *) userId;
-(void)updateUser:(User *)user withUserId:(NSString *) userId;
-(void)changePassword:(NSString *)password;
-(void)insertPost:(Post*) post;
-(void)deletePost:(Post*) post;
-(void)updatePost:(Post*) post;
@end
