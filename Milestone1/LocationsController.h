//
//  LocationsController.h
//  PaceMkr
//
//  Created by Shane Matthews on 11/23/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface LocationsController : UIViewController <UITableViewDelegate, UITableViewDataSource, CLLocationManagerDelegate>

@property (nonatomic, retain) IBOutlet UITableView *locationtable;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic, strong) CLLocation *current;

- (IBAction)fetchLocations;

@end
