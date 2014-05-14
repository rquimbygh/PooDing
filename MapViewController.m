//
//  MapViewController.m
//  PooDing
//
//  Created by Rachel Quimby on 1/6/14.
//  Copyright (c) 2014 Rachel Quimby. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()

@end

@implementation MapViewController
@synthesize fromAddr;
@synthesize fromPOICoordinate;
@synthesize isAddrPresent;
@synthesize delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    if (self.isAddrPresent)
        [self performStringGeocode:self.fromAddr];
    else if (self.isLocSwitchOn)
        [self userLocFollowWithHeading];
}

- (void)performStringGeocode:(NSString*) addr{
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:addr
                 completionHandler:^(NSArray *placemarks, NSError *error){
                     if (error)
                     {
                         NSLog(@"Geocode failed with error: %@", error);
                         return;
                     }
                     CLPlacemark *placemark = [placemarks firstObject];
                     [self sendPlacemark:placemark];
                 }];
}

- (void)sendPlacemark:(CLPlacemark*) placemark{
    dispatch_async(dispatch_get_main_queue(), ^{
        fromPOICoordinate = placemark.location.coordinate;
        MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(self.fromPOICoordinate, 750, 750);
        [self.mapView setRegion:viewRegion animated:YES];
    });
}

- (void)userLocFollowWithHeading
{
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollowWithHeading;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
