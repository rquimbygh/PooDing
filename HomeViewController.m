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
BOOL locationServicesEnabled;
UISwitch *locSwitch;
UITextField *addressTF;
CLLocationCoordinate2D poiCoordinate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter]addObserver:self
                                            selector:@selector(returnToActiveState:)
                                            name:UIApplicationDidBecomeActiveNotification
                                            object:nil];
}

-(void)returnToActiveState:(NSNotification *) notification{
    [self setLocVariables];
}

-(void)setLocVariables{
    if ([CLLocationManager locationServicesEnabled]) {
        locationServicesEnabled = YES;
        [_locSwitch setOn:YES animated:YES];
    }
    else{
        locationServicesEnabled = NO;
        [_locSwitch setOn:NO animated:YES];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    [self setLocVariables];
    _addressTF.delegate = self;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [_locSwitch setOn:NO animated:YES];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"mapSegue"]){
        if (![self locatable]) {
            return;
        }
        if ([_locSwitch isOn]) {
            MapViewController *mVC = (MapViewController*) [segue destinationViewController];
            mVC.isLocSwitchOn = YES;
            [mVC setDelegate:self];
        }
        else if (addressPresent){
            MapViewController *mVC = (MapViewController*)[segue destinationViewController];
            mVC.fromAddr = _addressTF.text;
            mVC.isAddrPresent = addressPresent;
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
    //check for location services enabled
    if ([CLLocationManager locationServicesEnabled])
        locationServicesEnabled = YES;
    else
        locationServicesEnabled = NO;
    //display alert if location services is off and there's no address
    if (!locationServicesEnabled && !addressPresent){
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Location Servies Disabled"
                              message:@"Unable to locate user. Enter address or enable location services in Settings"
                              delegate:self
                              cancelButtonTitle:@"OK"
                              otherButtonTitles:@"Go to Settings", nil];
        [alert show];
        return NO;
    }
    //nothing's amiss
    return YES;
}

-(void)viewDidDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter]removeObserver:self
                                                   name:UIApplicationDidBecomeActiveNotification
                                                 object:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
