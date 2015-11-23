//
//  LocationsController.m
//  PaceMkr
//
//  Created by Shane Matthews on 11/23/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <MapKit/MapKit.h>
#import "LocationsController.h"
#import "LocationsTableViewCell.h"

@interface LocationsController ()
@property (nonatomic, strong) NSArray *locations;
@property (nonatomic, strong) NSDictionary *locationlist;
@property bool found;
@end

extern CLLocation *Location1;

@implementation LocationsController

- (IBAction)fetchGreeting;
{
    NSLog(@"Fetching...");
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/shmatthews94/PaceMkr/master/Milestone1/locations2.json"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (data.length > 0)
                {
                    NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
                    self.locations = [NSJSONSerialization JSONObjectWithData:data
                                                                     options:0
                                                                       error:NULL];
                    self.locationlist = greeting;
                    //self.locations = [greeting allKeys];
                    // self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
                    //self.greetingContent.text = [greeting objectForKey:@"content"];
                }
                else if(error) {
                    NSLog(@"Error reading JSON!");
                }
                // handle response
                
            }] resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchGreeting];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    if(self.found == false) {
        self.current = [[CLLocation alloc] initWithLatitude:self.locationManager.location.coordinate.latitude
                                                  longitude:self.locationManager.location.coordinate.longitude];
    }
    self.found = true;
    [self.locationManager stopUpdatingLocation];
    
    NSString *latPoint = [NSString stringWithFormat:@"%f", self.current.coordinate.latitude];
    NSString *lonPoint = [NSString stringWithFormat:@"%f", self.current.coordinate.longitude];
    
    NSLog(@"lat is %@ : lon is %@",latPoint, lonPoint);
    [self.locationtable reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.locationlist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"LocationCell";
    
    LocationsTableViewCell *cell = (LocationsTableViewCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    /*
     if (cell == nil) {
     cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
     }
     */
    
    NSDictionary *item = self.locations[(NSUInteger)indexPath.row];
    NSString *name = [item objectForKey:@"building_name"];
    
    cell.namelabel.text = [NSString stringWithFormat:@"%@", name];
    //cell.distancelabel.text = [NSString stringWithFormat:@"%@", lon];
    CLLocation *point = [[CLLocation alloc] initWithLatitude:[[item objectForKey:@"x_coordinate"] doubleValue]
                                                   longitude:[[item objectForKey:@"y_coordinate"] doubleValue]];
    CLLocationDistance distance = [point distanceFromLocation:Location1]/1609.34;
    cell.distancelabel.text = [NSString stringWithFormat:@"%.1f mi away", distance];
    NSLog(@"distance is %.1f",distance);
    [cell.map addTarget:self action:@selector(mapclicked:) forControlEvents:UIControlEventTouchUpInside];
    /*
    cell.addresslabel.text = [item objectForKey:@"Address"];
    cell.citylabel.text = [item objectForKey:@"City"];
    cell.phonenumberlabel.text = [item objectForKey:@"Phone"];
    cell.latitude = [[item objectForKey:@"Latitude"] doubleValue];
    cell.longitude = [[item objectForKey:@"Longitude"] doubleValue];
    cell.map.tag = indexPath.row;
    cell.phone.tag = indexPath.row;
    [cell.map addTarget:self action:@selector(mapclicked:) forControlEvents:UIControlEventTouchUpInside];
    [cell.phone addTarget:self action:@selector(phoneclicked:) forControlEvents:UIControlEventTouchUpInside];
    
    CLLocation *store = [[CLLocation alloc] initWithLatitude:[[item objectForKey:@"Latitude"] doubleValue]
                                                   longitude:[[item objectForKey:@"Longitude"] doubleValue]];
    */
    /*
     
     MKPlacemark *location1 = [[MKPlacemark alloc]initWithCoordinate:(CLLocationCoordinate2DMake([[item objectForKey:@"Latitude"] doubleValue], [[item objectForKey:@"Longitude"] doubleValue])) addressDictionary:nil];
     MKMapItem *dir1 =[[MKMapItem alloc]initWithPlacemark:location1];
     
     MKPlacemark *location2 = [[MKPlacemark alloc]initWithCoordinate:(CLLocationCoordinate2DMake(self.current.coordinate.latitude, self.current.coordinate.longitude)) addressDictionary:nil];
     MKMapItem *dir2 =[[MKMapItem alloc]initWithPlacemark:location2];
     
     
     
     MKDirectionsRequest *request = [[MKDirectionsRequest alloc] init];
     
     // source and destination are the relevant MKMapItem's
     request.source = dir1;
     request.destination = dir2;
     
     // Specify the transportation type
     request.transportType = MKDirectionsTransportTypeAutomobile;
     
     // If you're open to getting more than one route, requestsAlternateRoutes = YES; else requestsAlternateRoutes = NO;
     request.requestsAlternateRoutes = NO;
     
     MKDirections *directions = [[MKDirections alloc] initWithRequest:request];
     
     [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
     
     if (!error) {
     self.response = response;
     }
     }];
     MKRoute *route = self.response.routes[indexPath.row];
     */
    //CLLocationDistance distance = route.distance;
    
    /*
     NSString *latPoint = [NSString stringWithFormat:@"%f", self.current2.coordinate.latitude];
     NSString *lonPoint = [NSString stringWithFormat:@"%f", self.current2.coordinate.longitude];
     NSLog(@"lat is %@ : lon is %@",latPoint, lonPoint);
     */
    
    // Then use it
    
    //cell.addresslabel.text = [locations objectAtIndex:indexPath.row];
    //cell.imageView.image = [UIImage imageNamed:@"creme_brelee.jpg"];
    
    return cell;
}

-(IBAction)mapclicked:(UIButton*)sender {
    NSDictionary *item = self.locations[(NSUInteger)sender.tag];
    MKPlacemark *location = [[MKPlacemark alloc]initWithCoordinate:(CLLocationCoordinate2DMake([[item objectForKey:@"Latitude"] doubleValue], [[item objectForKey:@"Longitude"] doubleValue])) addressDictionary:nil];
    MKMapItem *store =[[MKMapItem alloc]initWithPlacemark:location];
    
    [store openInMapsWithLaunchOptions:nil];
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
