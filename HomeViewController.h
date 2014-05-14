//
//  HomeViewController.h
//  PooDing
//
//  Created by Rachel Quimby on 1/6/14.
//  Copyright (c) 2014 Rachel Quimby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MapViewController.h"

@interface HomeViewController : UIViewController <passCoordinates, UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *searchB;
@property (weak, nonatomic) IBOutlet UITextField *addressTF;
@property (weak, nonatomic) IBOutlet UISwitch *locSwitch;

@end
