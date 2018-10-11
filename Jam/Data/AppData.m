//
//  AppData.m
//  Jam
//
//  Created by 5661 on 5/6/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "AppData.h"

@implementation AppData

@synthesize rootNode, usersNode, dataNode, USER_ID, storageRef;
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
        //Set firebase node
        NSString *key = [[rootNode child:@"users/"] child:userId].key;
        
        //Prepare object for firebase
        NSDictionary* userObj =
        @{
          @"name": [user name],
          @"email": [user email],
          @"description": [user userDescription],
          @"portfolio": [user portfolioLink],
          @"img": @""
        };
        
        //Assign object to firebase node
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
    
    @try {
        AppAlerts* alert = [[AppAlerts alloc]init];
        if (userId == nil) {
            userId = [FIRAuth auth].currentUser.uid;
        }
        
        //Prepare object
        NSDictionary* userData = [[NSDictionary alloc]initWithObjectsAndKeys:
                                  user.name, @"name",
                                  user.email, @"email",
                                  user.userDescription, @"description",
                                  user.portfolioLink, @"portfolio",
                                  user.img, @"img", nil];
        
        //Set object on firebase
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
        //Update password on firebase
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
-(void)insertPost:(Post*) post{
    @try {
        //Get user id
        NSString *userID = [FIRAuth auth].currentUser.uid;
        
        //Get firebase node path
        NSString *postPath = [NSString stringWithFormat:@"data/posts"];
        
        //Get node key
        NSString *key = [[rootNode child:postPath] childByAutoId].key;
        
        //Prepare object
        NSDictionary* postDic = @{
                                  @"id":key,
                                  @"uid":userID,
                                  @"title":[post title],
                                  @"time": [post time],
                                  @"address": [post address],
                                  @"date": [post date],
                                  @"description": [post postDescription]
                                  };
        
        //Assign object to firebase node
        NSDictionary *childUpdate = @{[NSString stringWithFormat:@"%@/%@", postPath, key]: postDic};
        
        //Update object in fireabase
        [rootNode updateChildValues:childUpdate withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
            if (error == nil) {
                //Sucess
                AppAlerts* alert = [[AppAlerts alloc]init];
                [alert alertShowWithTitle:@"" andBody:@"New post succesfully added"];
            }
            else{
                //Error
                AppAlerts* alert = [[AppAlerts alloc]init];
                [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
            }
        }];
        
    } @catch (NSException *exception) {
        @throw exception.reason;
    }
}

//Deletes a post by Id
-(void)deletePost:(Post*) post{
    @try {
        //Check if user is authenticated
        if (FIRAuth.auth.currentUser != nil) {
            //Set node reference
            FIRDatabaseReference* node;
            node = [[[rootNode child:@"data"]child:@"posts"]child:post.postId];
            [node removeValue];
        }
    } @catch (NSException *exception) {
        @throw exception.reason;
    }
}

//Update Post
-(void)updatePost:(Post*) post{
    @try {
        //Check if user is authenticated
        if (FIRAuth.auth.currentUser != nil) {
            //Prepare object
            NSDictionary* postData = [[NSDictionary alloc]initWithObjectsAndKeys:
                                      post.postId, @"id",
                                      post.userId, @"uid",
                                      post.title, @"title",
                                      post.postDescription, @"description",
                                      post.date, @"date",
                                      post.time, @"time",
                                      post.address, @"address"
                                      , nil];
            //Insert object into firebase
            [[[[rootNode child:@"data"]child:@"posts"]child:post.postId]setValue:postData withCompletionBlock:^(NSError * _Nullable error, FIRDatabaseReference * _Nonnull ref) {
                if (error == nil) {
                    //Success
                    AppAlerts* alert = [[AppAlerts alloc]init];
                    [alert alertShowWithTitle:@"" andBody:@"Jam successful updated"];
                    
                }
                else{
                    //Error
                    AppAlerts* alert = [[AppAlerts alloc]init];
                    [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
                }
            }];
        }
    } @catch (NSException *exception) {
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
}

//Insert image into firebase storage
-(NSString*)insertImg:(UIImageView*)img{
    @try {
        //Set img quality
        CGFloat compressionQuality = 0.8;
        
        //Get user id
        USER_ID = [FIRAuth auth].currentUser.uid;
        
        //Init new user object
        User *user = [[User alloc] init];
        
        //Semaphore to execute async func
        dispatch_semaphore_t sema = dispatch_semaphore_create(0);
        
        //Check if image is passed
        if (img.image != nil) {
            
            //Image information
            NSString *imageID = [[NSUUID UUID] UUIDString];
            NSString *imageName = [NSString stringWithFormat:@"%@ %@",[NSString stringWithFormat:@"%@", USER_ID],[NSString stringWithFormat:@"/%@.jpg",imageID]];
            
            
            FIRStorage *storage = [FIRStorage storage];
            storageRef = [storage referenceForURL:@"gs://jamapp-edc6c.appspot.com"];
            
            //Firebase storage reference
            FIRStorageReference *imageRef = [storageRef child:imageName];
            FIRStorageMetadata *metadata = [[FIRStorageMetadata alloc]init];
            
            metadata.contentType = @"image/jpeg";
            NSData *imageData = UIImageJPEGRepresentation(img.image, compressionQuality);
            
            //Insert image into firebase storage
            [imageRef putData:imageData metadata:metadata completion:^(FIRStorageMetadata * _Nullable metadata, NSError * _Nullable error) {
                if (error == nil) {
                    //Success
                    
                    //Get IMG URL
                    [imageRef downloadURLWithCompletion:^(NSURL * _Nullable URL, NSError * _Nullable error) {
                        
                        user.img = URL.absoluteString;
                        
                        //dispatch semaphore
                        dispatch_semaphore_signal(sema);
                    }];
                }
                else{
                    //Error
                    AppAlerts* alert = [[AppAlerts alloc]init];
                    [alert alertShowWithTitle:@"ERROR" andBody:error.localizedDescription];
                }
            }];
        }
        while (dispatch_semaphore_wait(sema, DISPATCH_TIME_NOW)) {
            [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:10]];
        }
        
        return user.img;
    } @catch (NSException *exception) {
        AppAlerts* alert = [[AppAlerts alloc]init];
        [alert alertShowWithTitle:@"ERROR" andBody:exception.reason];
    }
}
@end
