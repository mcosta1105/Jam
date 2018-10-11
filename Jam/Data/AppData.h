//
//  AppData.h
//  Jam
//
//  Created by 5661 on 5/6/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "User.h"
#import "Post.h"
#import "AppAlerts.h"
@import Firebase;

@interface AppData : NSObject

//Properties
@property (nonatomic) FIRDatabaseReference * rootNode;
@property (nonatomic) FIRDatabaseReference * dataNode;
@property (nonatomic) FIRDatabaseReference * usersNode;
@property (strong, nonatomic) FIRStorageReference *storageRef;
@property NSString *USER_ID;

//Methods
-(void)insertUser:(User *)user withUserId:(NSString *) userId;
-(void)updateUser:(User *)user withUserId:(NSString *) userId;
-(void)changePassword:(NSString *)password;
-(NSString*)insertImg:(UIImageView*)img;
-(void)insertPost:(Post*) post;
-(void)deletePost:(Post*) post;
-(void)updatePost:(Post*) post;

@end
