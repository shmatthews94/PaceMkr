//
//  MapViewController.m
//  PaceMkr
//
//  Created by Shane Matthews on 10/28/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "MapViewController.h"

@interface MapViewController ()


@end

extern NSDecimalNumber *TotalDistance;

@implementation MapViewController
@synthesize Distance;

- (void)viewDidLoad {
    [super viewDidLoad];
    NSNumberFormatter * nf = [[NSNumberFormatter alloc] init];
    [nf setMinimumIntegerDigits:1];
    [nf setMinimumFractionDigits:2];
    [nf setMaximumFractionDigits:2];
    NSString *rounded  = [nf stringFromNumber:TotalDistance];
    Distance.text = [NSString stringWithFormat:@"%@ mi", rounded];
    self.mapView.showsUserLocation = YES;
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

- (IBAction)Reset:(id)sender {
    
    NSDecimalNumber *zero = (NSDecimalNumber *) [NSDecimalNumber numberWithDouble:0.0];
    TotalDistance = zero;
    
    Distance.text = [NSString stringWithFormat:@"0.00 mi"];
}
@end
