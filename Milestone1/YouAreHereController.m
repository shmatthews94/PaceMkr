//
//  YouAreHereController.m
//  Milestone1
//
//  Created by Chase Deets on 10/21/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "YouAreHereController.h"


@interface YouAreHereController ()
@property bool found;

@end

@implementation YouAreHereController

- (void)viewDidLoad {
    [super viewDidLoad];
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
        [self.locationManager requestWhenInUseAuthorization];
    if ([CLLocationManager locationServicesEnabled]) {
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        self.locationManager.distanceFilter = kCLDistanceFilterNone;
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest; // 100 m
        [self.locationManager startUpdatingLocation];
    
    }

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(self.found == false) {
        self.current = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude
                                                  longitude:self.locationManager.location.coordinate.longitude];
        self.current2 = self.current;
    }
    self.found = true;
    [self.locationManager stopUpdatingLocation];
    
    NSString *latPoint = [NSString stringWithFormat:@"%f", self.current.coordinate.latitude];
    NSString *lonPoint = [NSString stringWithFormat:@"%f", self.current.coordinate.longitude];
    
    NSLog(@"lat is %@ : lon is %@",latPoint, lonPoint);
    
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
