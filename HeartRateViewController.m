//
//  HeartRateViewController.m
//  PaceMkr
//
//  Created by Chase Deets on 11/2/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "HeartRateViewController.h"
#import "HKHealthStore+AAPLExtensions.h"

@interface HKUnit (HKManager)
+ (HKUnit *)heartBeatsPerMinuteUnit;
@end

@implementation HKUnit (HKManager)

+ (HKUnit *)heartBeatsPerMinuteUnit {
    return [[HKUnit countUnit] unitDividedByUnit:[HKUnit minuteUnit]];
}

@end

@interface HeartRateViewController ()

@property (nonatomic, weak) IBOutlet UILabel *heightValueLabel;
@property (nonatomic, weak) IBOutlet UILabel *heightUnitLabel;


@end

@implementation HeartRateViewController
@synthesize HeartRate;



- (void)readHealthKitData{
    HKHealthStore *healthStore = [[HKHealthStore alloc] init];
    NSSet *shareObjectTypes = [NSSet setWithObjects:
                               nil];
    NSSet *readObjectTypes  = [NSSet setWithObjects:
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierDistanceWalkingRunning],
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierFlightsClimbed],
                               [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierStepCount],
                               nil];
    // Request access
    [healthStore requestAuthorizationToShareTypes:shareObjectTypes
                                        readTypes:readObjectTypes
                                       completion:^(BOOL success, NSError *error) {
                                           if(success == YES)
                                           {
                                               //[self queryHealthData];
                                               //[self queryHealthDataDistance];
                                               //[self queryHealthDataFlights];
                                               [self queryHealthDataHeart];
                                           }
                                           else
                                           {
                                               // Determine if it was an error or if the
                                               // user just canceld the authorization request
                                           }
                                           
                                       }];}

- (void)queryHealthDataHeart{
    HKQuantityType *typeHeart =[HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear| NSCalendarUnitMonth | NSCalendarUnitDay
                                               fromDate:now];
    NSDate *beginOfDay = [calendar dateFromComponents:components];
    NSPredicate *predicate = [HKQuery predicateForSamplesWithStartDate:beginOfDay endDate:now options:HKQueryOptionStrictStartDate];
    NSLog(@"About to query");
    HKStatisticsQuery *squery = [[HKStatisticsQuery alloc] initWithQuantityType:typeHeart quantitySamplePredicate:predicate options:HKStatisticsOptionDiscreteAverage completionHandler:^(HKStatisticsQuery *query, HKStatistics *result, NSError *error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            HKQuantity *quantity = result.averageQuantity;
            double beats = [quantity doubleValueForUnit:[HKUnit heartBeatsPerMinuteUnit]];
            NSLog([NSString stringWithFormat:@"Heart rate average: %@", quantity]);
            self.heightValueLabel.text = [NSString stringWithFormat:@"%.f",beats];
        });
    }];
    [self.healthStore executeQuery:squery];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self readHealthKitData];
    NSString *HeartBeat;
    HeartBeat = @"000 BPM";
    NSDate *now = [NSDate date];
    HeartRate.text = HeartBeat;
    
    if ([HKHealthStore isHealthDataAvailable]) {
        NSSet *writeDataTypes = [self dataTypesToWrite];
        NSSet *readDataTypes = [self dataTypesToRead];
        
        [self.healthStore requestAuthorizationToShareTypes:writeDataTypes readTypes:readDataTypes completion:^(BOOL success, NSError *error) {
            if (!success) {
                NSLog(@"You didn't allow HealthKit to access these read/write data types. In your app, try to handle this error gracefully when a user decides not to provide access. The error was: %@. If you're using a simulator, try it on a device.", error);
                
                return;
            }
            
        }];
    }

    
//    if(NSClassFromString(@"HKHealthStore") && [HKHealthStore isHealthDataAvailable])
//    {
//        NSLog(@"Heath data available!");
//        NSSet *readObjectTypes  = [NSSet setWithObjects:
//                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate],
//                                   nil];
//        
//        NSSet *shareObjectTypes = [NSSet setWithObjects:
//                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight],
//                                   nil];
//        
//        HKQuantity *energyBurned =
//        [HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit]
//                         doubleValue:425.0];
//        
//        HKQuantity *distance =
//        [HKQuantity quantityWithUnit:[HKUnit mileUnit]
//                         doubleValue:3.2];
//        
//        // Provide summary information when creating the workout.
//        HKWorkout *run = [HKWorkout workoutWithActivityType:HKWorkoutActivityTypeRunning
//                                                  startDate:now
//                                                    endDate:now
//                                                   duration:0
//                                          totalEnergyBurned:energyBurned
//                                              totalDistance:distance
//                                                   metadata:nil];
//        
//        
//    
//    
//        [self.healthStore requestAuthorizationToShareTypes:shareObjectTypes
//                                            readTypes:readObjectTypes
//                                           completion:^(BOOL success, NSError *error) {
//                                               if(success == YES)
//                                               {
//                                                   NSLog(@"Successfully connected to heathkit and created workout!");
//                                                   
//                                                   NSMutableArray *samples = [NSMutableArray array];
//                                                   
//                                                   HKQuantityType *energyBurnedType =
//                                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierActiveEnergyBurned];
//                                                   
//                                                   HKQuantity *energyBurnedPerInterval =
//                                                   [HKQuantity quantityWithUnit:[HKUnit kilocalorieUnit]
//                                                                    doubleValue:15.5];
//                                                   
//                                                   HKQuantitySample *energyBurnedPerIntervalSample =
//                                                   [HKQuantitySample quantitySampleWithType:energyBurnedType
//                                                                                   quantity:energyBurnedPerInterval
//                                                                                  startDate:now
//                                                                                    endDate:now];
//                                                   
//                                                   [samples addObject:energyBurnedPerIntervalSample];
//                                                   
//                                                   HKQuantityType *heartRateType =
//                                                   [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
//                                                   
//                                                   HKQuantity *heartRateForInterval =
//                                                   [HKQuantity quantityWithUnit:[HKUnit unitFromString:@"count/min"]
//                                                                    doubleValue:95.0];
//                                                   
//                                                   HKQuantitySample *heartRateForIntervalSample =
//                                                   [HKQuantitySample quantitySampleWithType:heartRateType
//                                                                                   quantity:heartRateForInterval
//                                                                                  startDate:now
//                                                                                    endDate:now];
//                                                   
//                                                   [samples addObject:heartRateForIntervalSample];
//                                                   
//                                                   [self.healthStore
//                                                    addSamples:samples
//                                                    toWorkout:run
//                                                    completion:^(BOOL success, NSError *error) {
//                                                        if (!success) {
//                                                            // Perform proper error handling here...
//                                                            NSLog(@"*** An error occurred while adding a "
//                                                                  @"sample to the workout: %@ ***",
//                                                                  error.localizedDescription);
//                                                            //this line breaks it now
//                                                            //abort();
//                                                        }
//                                                    }];
//
//
//                                                   
//                                                   
//
//                                               }
//                                               else
//                                               {
//                                                   NSLog(@"Failed to complete HealthKit Auth Req");
//                                                   // Determine if it was an error or if the
//                                                   // user just canceldthe authorization request
//                                               }
//                                           }];
//        
//        
//        
//    }
}

- (NSSet *)dataTypesToWrite {
    HKQuantityType *heartRateType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];

    return [NSSet setWithObjects:heartRateType, nil];
}

- (NSSet *)dataTypesToRead {
    HKQuantityType *heartRateType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeartRate];
    HKQuantityType *heightType = [HKObjectType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];

    return [NSSet setWithObjects:heartRateType, heightType, nil];

}


- (IBAction)updateUsersHeighLabel:(id)sender {
    //[self updateUsersHeightLabel];
    [self queryHealthDataHeart];
}
/*

- (void)readHeight {
    
    //HKUnit *preferredUnit = [self getUnit:unit:@"HKLengthUnit"];
    
    // Query to get the user's latest height, if it exists.
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    NSSet *requestTypes = [NSSet setWithObjects: heightType, nil];
    // always ask for read and write permission if the app uses both, because granting read will remove write for the same type :(
    
    [self.healthStore requestAuthorizationToShareTypes:requestWritePermission ? requestTypes : nil readTypes:requestTypes completion:^(BOOL success, NSError *error) {
        if (success) {
            [self.healthStore aapl_mostRecentQuantitySampleOfType:heightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSDate *mostRecentDate, NSError *errorInner) { // TODO use
                if (mostRecentQuantity) {
                    double usersHeight = [mostRecentQuantity doubleValueForUnit:preferredUnit];
                    NSDateFormatter *df = [[NSDateFormatter alloc] init];
                    [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                    NSMutableDictionary *entry = [[NSMutableDictionary alloc] initWithObjectsAndKeys:
                                                  [NSNumber numberWithDouble:usersHeight], HKPluginKeyValue,
                                                  unit, HKPluginKeyUnit,
                                                  [df stringFromDate:mostRecentDate], @"date",
                                                  nil];
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:errorInner.localizedDescription];
                        [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
                    });
                }
            }];
        } else {
            dispatch_sync(dispatch_get_main_queue(), ^{
                CDVPluginResult* result = [CDVPluginResult resultWithStatus:CDVCommandStatus_ERROR messageAsString:error.localizedDescription];
                [self.commandDelegate sendPluginResult:result callbackId:command.callbackId];
            });
        }
    }];
}
 */

- (void)updateUsersHeightLabel {
    // Fetch user's default height unit in inches.
    NSLengthFormatter *lengthFormatter = [[NSLengthFormatter alloc] init];
    lengthFormatter.unitStyle = NSFormattingUnitStyleLong;
    
    NSLengthFormatterUnit heightFormatterUnit = NSLengthFormatterUnitInch;
    NSString *heightUnitString = [lengthFormatter unitStringFromValue:10 unit:heightFormatterUnit];
    NSString *localizedHeightUnitDescriptionFormat = NSLocalizedString(@"Height (%@)", nil);
    
    self.heightUnitLabel.text = [NSString stringWithFormat:localizedHeightUnitDescriptionFormat, heightUnitString];
    
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    NSLog(@"About to Query");
    
    
    // Query to get the user's latest height, if it exists.
    [self.healthStore aapl_mostRecentQuantitySampleOfType:heightType predicate:nil completion:^(HKQuantity *mostRecentQuantity, NSError *error) {
        NSLog(@"QUERY");
        if (!mostRecentQuantity) {
            NSLog(@"Either an error occured fetching the user's height information or none has been stored yet. In your app, try to handle this gracefully.");
            
                self.heightValueLabel.text = NSLocalizedString(@"Not available", nil);
            
        }
        else {
            NSLog(@"should be printing height here");
            // Determine the height in the required unit.
            HKUnit *heightUnit = [HKUnit inchUnit];
            double usersHeight = [mostRecentQuantity doubleValueForUnit:heightUnit];
            self.heightValueLabel.text = [NSString stringWithFormat:@"%f", usersHeight];

        }
    }];
}



- (void)saveHeightIntoHealthStore:(double)height {
    // Save the user's height into HealthKit.
    HKUnit *inchUnit = [HKUnit inchUnit];
    HKQuantity *heightQuantity = [HKQuantity quantityWithUnit:inchUnit doubleValue:height];
    
    HKQuantityType *heightType = [HKQuantityType quantityTypeForIdentifier:HKQuantityTypeIdentifierHeight];
    NSDate *now = [NSDate date];
    
    HKQuantitySample *heightSample = [HKQuantitySample quantitySampleWithType:heightType quantity:heightQuantity startDate:now endDate:now];
    
    [self.healthStore saveObject:heightSample withCompletion:^(BOOL success, NSError *error) {
        if (!success) {
            NSLog(@"An error occured saving the height sample %@. In your app, try to handle this gracefully. The error was: %@.", heightSample, error);
            abort();
        }
        
        [self updateUsersHeightLabel];
    }];
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
