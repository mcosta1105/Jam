//
//  AppData.h
//  Jam
//
//  Created by Isabele Araujo on 5/6/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Firebase.h>

@interface AppData : NSObject

@property (nonatomic) FIRDatabaseReference * rootNode;
@property (nonatomic) FIRDatabaseReference * dataNode;
@property (nonatomic) FIRDatabaseReference * usersNode;

@end
