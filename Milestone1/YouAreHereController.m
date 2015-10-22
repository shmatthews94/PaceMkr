//
//  YouAreHereController.m
//  Milestone1
//
//  Created by Chase Deets on 10/21/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "YouAreHereController.h"

#pragma mark - View LifeCycle

@interface YouAreHereController ()
{
    CLGeocoder *geocoder;
    CLPlacemark *placemark;
}
@end

extern NSString *NameID;

@implementation YouAreHereController
@synthesize locationManager;
@synthesize latitude, longitude;
@synthesize current;
@synthesize name;
@synthesize data;

- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager requestWhenInUseAuthorization];
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    name.text = data;
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    // Turn off the location manager to save power.
    [self.locationManager stopUpdatingLocation];
}

#pragma mark - CLLocationManager delegate methods

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude
                                              longitude:self.locationManager.location.coordinate.longitude];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil) {
            placemark = [placemarks lastObject];
            latitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            longitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            name.text = NameID;
            NSLog(@"lat is %f : lon is %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    [locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    NSLog(@"Cannot find the location.");
}


@end
