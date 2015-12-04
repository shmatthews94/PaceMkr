//
//  MapViewController.m
//  PaceMkr
//
//  Created by Shane Matthews on 10/28/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController () {
    CLGeocoder *geocoder;
}


@end

extern NSDecimalNumber *TotalDistance;
extern CLLocation *Location1;
extern CLLocation *Location2;

@implementation MapViewController
@synthesize Distance;
@synthesize locationManager;
@synthesize mainDelegate;

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    self = [super initWithNibName:nibName bundle:nibBundle];
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    geocoder = [[CLGeocoder alloc] init];
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyBest;
    locationManager.distanceFilter=kCLDistanceFilterNone;
    [locationManager startMonitoringSignificantLocationChanges];
    [locationManager startUpdatingLocation];
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumIntegerDigits:1];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    NSString *rounded  = [nf stringFromNumber:TotalDistance];
    Distance.text = [NSString stringWithFormat:@"%@ mi", rounded];
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
    mainDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    //self.locations = [NSMutableArray array];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    NSLog(@"Updated location");
    CLLocation *location = [locations lastObject];

    
    [mainDelegate.sharedArray addObject:location];
    NSUInteger count = [mainDelegate.sharedArray count];
    NSLog([NSString stringWithFormat:@"Count: %i", count]);
    
    if (count > 1) {
        CLLocationCoordinate2D coordinates[count];
        for (NSInteger i = 0; i < count; i++) {
            coordinates[i] = [(CLLocation *)mainDelegate.sharedArray[i] coordinate];
    }
        
    MKPolyline *oldPolyline = self.polyline;
    self.polyline = [MKPolyline polylineWithCoordinates:coordinates count:count];
    [self.mapView addOverlay:self.polyline];
    if (oldPolyline) {
        [self.mapView removeOverlay:oldPolyline];
    }
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude
                                                             longitude:self.locationManager.location.coordinate.longitude];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
            
        if (error == nil) {
                
            Location1 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
            CLLocationDistance distance = [Location2 distanceFromLocation:Location1];
            double diffmiles = distance/1609.34;
            double total = [TotalDistance doubleValue];
            double new = total + diffmiles;
            double new2 = floorf(new * 100) / 100;
            NSLog(@"Total Distance is: %f", new);
            NSLog(@"lat is %f : lon is %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
            NSDecimalNumber *finaltotal = (NSDecimalNumber *) [NSDecimalNumber numberWithDouble:new2];
            TotalDistance = finaltotal;
            NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
            [nf setMinimumIntegerDigits:1];
            [nf setMinimumFractionDigits:2];
            [nf setMaximumFractionDigits:2];
            NSString *rounded  = [nf stringFromNumber:TotalDistance];
            Distance.text = [NSString stringWithFormat:@"%@ mi", rounded];
            Location2 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];

            
            NSLog(@"lat is %f : lon is %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
                
            } else {
                NSLog(@"%@", error.debugDescription);
            }
        } ];
}
    
    
    /*
    CLLocation *newLocation = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude
                                                         longitude:self.locationManager.location.coordinate.longitude];
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *placemarks, NSError *error) {
        
        if (error == nil) {
            
            Location1 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
            CLLocationDistance distance = [Location2 distanceFromLocation:Location1];
            double diffmiles = distance/1609.34;
            double total = [TotalDistance doubleValue];
            double new = total + diffmiles;
            double new2 = floorf(new * 100) / 100;
            NSLog(@"Total Distance is: %f", new);
            NSLog(@"lat is %f : lon is %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
            NSDecimalNumber *finaltotal = (NSDecimalNumber *) [NSDecimalNumber numberWithDouble:new2];
            TotalDistance = finaltotal;
            MKMapPoint * pointsArray = malloc(sizeof(CLLocationCoordinate2D)*50);
            pointsArray[0]= MKMapPointForCoordinate(Location1.coordinate);
            pointsArray[1]= MKMapPointForCoordinate(Location2.coordinate);
                
            self.routeLine = [MKPolyline polylineWithPoints:pointsArray count:2];
            free(pointsArray);
            
            Location2 = [[CLLocation alloc] initWithLatitude:newLocation.coordinate.latitude longitude:newLocation.coordinate.longitude];
            
            NSLog(@"lat is %f : lon is %f", newLocation.coordinate.latitude, newLocation.coordinate.longitude);
            
        } else {
            NSLog(@"%@", error.debugDescription);
        }
    } ];
    [locationManager stopUpdatingLocation];
    
    

    [[self mapView] addOverlay:self.routeLine];
    */
    
}

#pragma mark - MKMapViewDelegate

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay
{
    if ([overlay isKindOfClass:[MKPolyline class]])
    {
        MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
        
        renderer.strokeColor = [[UIColor blueColor] colorWithAlphaComponent:0.7];
        renderer.lineWidth   = 3;
        
        return renderer;
    }
    
    return nil;
}


- (IBAction)Reset:(id)sender {
    
    NSDecimalNumber *zero = (NSDecimalNumber *) [NSDecimalNumber numberWithDouble:0.0];
    TotalDistance = zero;
    
    Distance.text = [NSString stringWithFormat:@"0.00 mi"];
}
@end
