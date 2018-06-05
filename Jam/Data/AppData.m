//
//  AppData.m
//  Jam
//
//  Created by Isabele Araujo on 5/6/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "AppData.h"

@implementation AppData

//Constructor
-(id)init{
    
    if(self){
        
        [FIRApp configure];
        _rootNode = [[FIRDatabase database] reference];
        _usersNode = [_rootNode child:@"users"];
        _dataNode = [_rootNode child:@"data"];
        
    }
    
    return self;
}
@end
