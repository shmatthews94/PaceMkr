//
//  NoWatchViewController.m
//  PaceMkr
//
//  Created by Chase Deets on 11/4/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "NoWatchViewController.h"

@interface NoWatchViewController ()

@end

@implementation NoWatchViewController
@synthesize HeartRate;
@synthesize UpdateButton;
@synthesize bpmBox;



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)updateBpm:(id)sender {
    NSString *bpm;
    bpm = bpmBox.text;
    HeartRate.text = bpm;
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
