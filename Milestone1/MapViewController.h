//
//  MapViewController.h
//  PaceMkr
//
//  Created by Shane Matthews on 10/28/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <MapKit/MKAnnotation.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

@interface MapViewController : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>

@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (weak, nonatomic) IBOutlet UILabel *Distance;
@property (nonatomic, strong) MKPolyline* polyline;
@property (nonatomic, strong) MKPolylineView* routeLineView;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, retain) AppDelegate *mainDelegate;
- (IBAction)Reset:(id)sender;

@end
