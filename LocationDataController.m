//
//  LocationDataController.m
//  PooDing
//
//  Created by Rachel Quimby on 1/6/14.
//  Copyright (c) 2014 Rachel Quimby. All rights reserved.
//
//  (Model Class)

#import "LocationDataController.h"

@implementation LocationDataController

-(Location*)getPointofInterest
{
    Location *myLocation = [[Location alloc] init];
    
    myLocation.latitude = 37.781453;
    myLocation.longitude = -122.417158;
    
    return myLocation;
}

@end
