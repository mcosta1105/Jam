//
//  Gradients.m
//  Jam
//
//  Created by 5661 on 10/5/18.
//  Copyright © 2018 5661. All rights reserved.
//

#import "Gradients.h"

@implementation Gradients

//Grey gradient for Background
+(CAGradientLayer*) backgroundGradient{
    
    UIColor *colorOne = [UIColor colorWithRed:(255/255.0) green:(255/255.0) blue:(255/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(238/255.0) green:(238/255.0) blue:(238/255.0) alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
}

//Purple/pink gradient for buttons
+(CAGradientLayer*) buttonGradient{
    
    UIColor *colorOne = [UIColor colorWithRed:(150/255.0) green:(93/255.0) blue:(206/255.0) alpha:1.0];
    UIColor *colorTwo = [UIColor colorWithRed:(245/255.0) green:(57/255.0) blue:(134/255.0) alpha:1.0];
    
    NSArray *colors = [NSArray arrayWithObjects:(id)colorOne.CGColor, colorTwo.CGColor, nil];
    
    NSNumber *stopOne = [NSNumber numberWithFloat:0.0];
    NSNumber *stopTwo = [NSNumber numberWithFloat:1.0];
    
    NSArray *locations = [NSArray arrayWithObjects:stopOne, stopTwo, nil];
    
    CAGradientLayer *headerLayer = [CAGradientLayer layer];
    headerLayer.colors = colors;
    headerLayer.locations = locations;
    
    return headerLayer;
}

@end
