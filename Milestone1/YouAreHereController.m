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
    CLPlacemark *placemark2;
    CLLocation *Location1;
    CLLocation *Location2;
}
@end

extern NSString *NameID;
extern NSString *THR;
extern NSDecimalNumber *TotalDistance;
@import HealthKit;

@implementation YouAreHereController
@synthesize locationManager;
@synthesize latitude, longitude;
@synthesize current;
@synthesize name;
@synthesize data;
@synthesize targetheartrate;

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
            
            Location1 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
            CLLocationDistance distance = [Location2 distanceFromLocation:Location1];
            double diffmiles = distance/1609.34;
            double total = [TotalDistance doubleValue];
            double new = total + diffmiles;
            NSLog(@"Total Distance is: %f", new);
            NSLog(@"lat is %f : lon is %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
            NSDecimalNumber *finaltotal = (NSDecimalNumber *) [NSDecimalNumber numberWithDouble:new];
            TotalDistance = finaltotal;
            Location2 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
            latitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.latitude];
            longitude.text = [NSString stringWithFormat:@"%f",newLocation.coordinate.longitude];
            name.text = NameID;
            targetheartrate.text = THR;
            placemark2 = [placemarks lastObject];
            
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

//healthKit code here























@end
