//
//  HeartRateViewController.m
//  PaceMkr
//
//  Created by Chase Deets on 11/2/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "HeartRateViewController.h"

@import HealthKit;

@interface HeartRateViewController ()
@end

@implementation HeartRateViewController
@synthesize HeartRate;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *HeartBeat;
    HeartBeat = @"000";
    NSDate *now = [NSDate date];
    HeartRate.text = HeartBeat;
    if(NSClassFromString(@"HKHealthStore") && [HKHealthStore isHealthDataAvailable])
    {
        HKHealthStore *healthStore = [[HKHealthStore alloc] init];
        NSSet *readObjectTypes  = [NSSet setWithObjects:
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],
                                   nil];
        
        NSSet *shareObjectTypes = [NSSet setWithObjects:
                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
                                   nil];
        
        HKQuantity *energyBurned =
        [HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit]
                         doubleValue:425.0];
        
        HKQuantity *distance =
        [HKQuantity quantityWithUnit:[HKUnit mileUnit]
                         doubleValue:3.2];
        
        // Provide summary information when creating the workout.
        HKWorkout *run = [HKWorkout workoutWithActivityType:HKWorkoutActivityTypeRunning
                                                  startDate:now
                                                    endDate:now
                                                   duration:0
                                          totalEnergyBurned:energyBurned
                                              totalDistance:distance
                                                   metadata:nil];
        
        
    
    
        [healthStore requestAuthorizationToShareTypes:shareObjectTypes
                                            readTypes:readObjectTypes
                                           completion:^(BOOL success, NSError *error) {
                                               if(success == YES)
                                               {
                                                   NSLog(@"Successfully connected to heathkit and created workout!");
                                                   
                                                   NSMutableArray *samples = [NSMutableArray array];
                                                   
                                                   HKQuantityType *energyBurnedType =
                                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
                                                   
                                                   HKQuantity *energyBurnedPerInterval =
                                                   [HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit]
                                                                    doubleValue:15.5];
                                                   
                                                   HKQuantitySample *energyBurnedPerIntervalSample =
                                                   [HKQuantitySample quantitySampleWithType:energyBurnedType
                                                                                   quantity:energyBurnedPerInterval
                                                                                  startDate:now
                                                                                    endDate:now];
                                                   
                                                   [samples addObject:energyBurnedPerIntervalSample];
                                                   
                                                   HKQuantityType *heartRateType =
                                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
                                                   
                                                   HKQuantity *heartRateForInterval =
                                                   [HKQuantity quantityWithUnit:[HKUnit unitFromString:@"count/min"]
                                                                    doubleValue:95.0];
                                                   
                                                   HKQuantitySample *heartRateForIntervalSample =
                                                   [HKQuantitySample quantitySampleWithType:heartRateType
                                                                                   quantity:heartRateForInterval
                                                                                  startDate:now
                                                                                    endDate:now];
                                                   
                                                   [samples addObject:heartRateForIntervalSample];
                                                   
                                                   [healthStore
                                                    addSamples:samples
                                                    toWorkout:run
                                                    completion:^(BOOL success, NSError *error) {
                                                        if (!success) {
                                                            // Perform proper error handling here...
                                                            NSLog(@"*** An error occurred while adding a "
                                                                  @"sample to the workout: %@ ***",
                                                                  error.localizedDescription);
                                                            
                                                            //abort();
                                                        }
                                                    }];


                                                   
                                                   

                                               }
                                               else
                                               {
                                                   NSLog(@"Failed to complete HealthKit Auth Req");
                                                   // Determine if it was an error or if the
                                                   // user just canceldthe authorization request
                                               }
                                           }];
        
        
        
    }
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

@end
