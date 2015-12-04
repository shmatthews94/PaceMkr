//
//  HeartRateViewController.h
//  PaceMkr
//
//  Created by Chase Deets on 11/2/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <UIKit/UIKit.h>

@import HealthKit;

@interface HeartRateViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *HeartRate;
@property (nonatomic) HKHealthStore *healthStore;


@end
