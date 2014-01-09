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
        MapViewController *mVC = (MapViewController*)[segue destinationViewController];
        NSString *fromLatitudeTF = _latitudeTF.text;
        NSString *fromLongitudeTF =_longitudeTF.text;
        mVC.fromLatTF = fromLatitudeTF;
        mVC.fromLonTF = fromLongitudeTF;
        [mVC setDelegate:self];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
