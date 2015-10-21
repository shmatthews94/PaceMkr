//
//  YouAreHereController.h
//  Milestone1
//
//  Created by Chase Deets on 10/21/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>


@interface YouAreHereController : UIViewController <CLLocationManagerDelegate>
@property (nonatomic, strong) CLLocation *current;
@property (nonatomic, strong) CLLocation *current2;
@property (nonatomic,retain) CLLocationManager *locationManager;
@property (nonatomic,retain) MKDirectionsResponse *response;

@end
