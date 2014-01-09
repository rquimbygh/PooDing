//
//  MapViewController.h
//  PooDing
//
//  Created by Rachel Quimby on 1/6/14.
//  Copyright (c) 2014 Rachel Quimby. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@protocol passCoordinates <NSObject>;

@end

@interface MapViewController : UIViewController <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) NSString *fromLatTF;
@property (nonatomic) NSString *fromLonTF;
@property (retain)id <passCoordinates> delegate;

@end
