//
//  HomeViewController.m
//  PooDing
//
//  Created by Rachel Quimby on 1/6/14.
//  Copyright (c) 2014 Rachel Quimby. All rights reserved.
//

#import "HomeViewController.h"
#import "MapViewController.h"


@interface HomeViewController ()

@end

@implementation HomeViewController

BOOL addressPresent;
BOOL latLongPresent;
BOOL locationServicesEnabled;
CLLocationCoordinate2D poiCoordinate;

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

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"mapSegue"]){
        
        if (![self locatable]) {
            return;
        }
        if (addressPresent){
            MapViewController *mVC = (MapViewController*)[segue destinationViewController];
            mVC.fromAddr = _addressTF.text;
            mVC.isAddrPresent = addressPresent;
            [mVC setDelegate:self];
        }
        else if (latLongPresent){
            MapViewController *mVC = (MapViewController*)[segue destinationViewController];
            NSString *fromLatitudeTF = _latitudeTF.text;
            NSString *fromLongitudeTF =_longitudeTF.text;
            mVC.fromLatTF = fromLatitudeTF;
            mVC.fromLonTF = fromLongitudeTF;
            mVC.isLatLongPresent = latLongPresent;
            [mVC setDelegate:self];
        }
    }
}

-(BOOL)locatable
{
    //check for address
    if ([_addressTF.text isEqualToString:@""])
        addressPresent = NO;
    else
        addressPresent = YES;
    //check for latitude & longitude
    if ([_longitudeTF.text isEqualToString:@""] && [_latitudeTF.text isEqualToString:@""])
        latLongPresent = NO;
    else
        latLongPresent = YES;
    //check for location services enabled
    if ([CLLocationManager locationServicesEnabled])
        locationServicesEnabled = YES;
    else
        locationServicesEnabled = NO;
    //display alert if either latitude or longitude is missing
    if (latLongPresent) {
        if ([_longitudeTF.text isEqualToString:@""] || [_latitudeTF.text isEqualToString:@""]){
            latLongPresent=NO;
            UIAlertView *alert = [[UIAlertView alloc]
                                  initWithTitle:@"Field Check"
                                  message:@"Both longitude and latitude must be present to search by coordinates"
                                  delegate:self
                                  cancelButtonTitle:@"OK"
                                  otherButtonTitles:nil,nil];
            [alert show];
            return NO;
        }
    }
    //display alert if location services is off and there's no address
    else if (!locationServicesEnabled && !addressPresent){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Field Check"
                              message:@"Unable to locate. Enter address or enable location services in Settings"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    //nothing's amiss
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
