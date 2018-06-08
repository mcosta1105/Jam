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


-(void)InsertUser:(User *)user withUserId:(NSString *) userId{
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


@end
