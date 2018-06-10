//
//  AppData.m
//  Jam
//
//  Created by Isabele Araujo on 5/6/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "AppData.h"

@implementation AppData

@synthesize rootNode, usersNode, dataNode, USER_ID;
//Constructor
-(id)init{
    
    self = [super init];
    
    if(self){
        
        //[FIRApp configure];
        rootNode = [[FIRDatabase database] reference];
        usersNode = [rootNode child:@"users"];
        dataNode = [rootNode child:@"data"];
        
        //Get Current User ID
        if(USER_ID == nil){
            USER_ID = [FIRAuth auth].currentUser.uid;
        }
        
    }
    
    return self;
}

//Insert user into Firebase
-(void)insertUser:(User *)user withUserId:(NSString *) userId{
    @try {
        
        NSString *key = [[rootNode child:@"users/"] child:userId].key;
        
        NSDictionary* userObj =
        @{
          @"name": [user name],
          @"email": [user email],
          @"description": [user userDescription],
          @"portfolio": [user portfolioLink]
        };
        
        NSDictionary *childUpdate = @{[[@"/users/" stringByAppendingString:key] stringByAppendingString:@"/profile"]: userObj};
        
        //Insert into DB
        [rootNode updateChildValues:childUpdate
                withCompletionBlock:^(NSError * _Nullable error,
                                      FIRDatabaseReference * _Nonnull ref)
         {
             if(error != nil){
                 //Error
                 AppAlerts* alert = [[AppAlerts alloc]init];
                 [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
             }
             else{
                 return;
             }
         }];
        
    } @catch (NSException *exception) {
        @throw exception.reason;
    }
}

//Update user in FIrebase
-(void)updateUser:(User *)user withUserId:(NSString *) userId{
    AppAlerts* alert = [[AppAlerts alloc]init];
    @try {
        if (userId == nil) {
            userId = [FIRAuth auth].currentUser.uid;
        }
        
        NSDictionary* userData = [[NSDictionary alloc]initWithObjectsAndKeys:
                                  user.name, @"name",
                                  user.email, @"email",
                                  user.userDescription, @"description",
                                  user.portfolioLink, @"portfolio", nil];
        [[[[rootNode child:@"users"]child:userId]child:@"profile"]setValue:userData withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if(error == nil){
                //Success
                [alert alertShowWithTitle:@"Update" andBody:@"Profile succesfull updated"];
            }
            else{
                //Error
                [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
            }
        }];
        
    } @catch (NSException *exception) {
        @throw exception.reason;
    }
}

//Change Password
-(void)changePassword:(NSString *)password{
    @try {
        [[FIRAuth auth].currentUser updatePassword:password completion:^(NSError * _Nullable error) {
            if(error == nil){
                return;
            }
        }];
    } @catch (NSException *exception) {
        @throw exception.reason;
    }
}

//Insert Jam Post
-(void)insertPost:(Post*)post{
    @try {
        NSString *userID = [FIRAuth auth].currentUser.uid;
        
        NSString *postPath = [NSString stringWithFormat:@"users/%@/posts", userID];
        
        NSString *key = [[rootNode child:postPath] childByAutoId].key;
        
        NSDictionary* postDic = @{
                                  @"title":[post title],
                                  @"time": [post time],
                                  @"address": [post address],
                                  @"date": [post date],
                                  @"description": [post postDescription]
                                  };
        NSDictionary *childUpdate = @{[NSString stringWithFormat:@"%@/%@", postPath, key]: postDic};
        
        [rootNode updateChildValues:childUpdate withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if (error == nil) {
                AppAlerts* alert = [[AppAlerts alloc]init];
                [alert alertShowWithTitle:@"" andBody:@"New post succesfully added"];
            }
            else{
                AppAlerts* alert = [[AppAlerts alloc]init];
                [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
            }
        }];
        
    } @catch (NSException *exception) {
        @throw exception.reason;
    }
}

@end
