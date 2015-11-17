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
@synthesize ChangeRate;
extern NSString *THR;


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
    int targHR = [THR intValue];
    bpm = bpmBox.text;
    int rate = [bpmBox.text intValue];
    int diff = targHR - rate;
    HeartRate.text = [NSString stringWithFormat:@"%d", rate];
    HeartRate.textColor = [UIColor blueColor];
    ChangeRate.textColor = [UIColor orangeColor];

    if(rate > (targHR - 10) && rate < (targHR + 10)){
        HeartRate.textColor = [UIColor greenColor];
    } else if (rate > (targHR - 25) && rate < (targHR + 25)){
        HeartRate.textColor = [UIColor yellowColor];
    }else{
        HeartRate.textColor = [UIColor redColor];
    }
    
    if(diff == 0){
        ChangeRate.text = [NSString stringWithFormat:@"Keep it up!"];
        
    }else if (diff > 0){
        ChangeRate.text = [NSString stringWithFormat:@"Increase BPM by: %d", diff];
    }else{
        diff = (diff * -1);
        ChangeRate.text = [NSString stringWithFormat:@"Decrease BPM by: %d", diff];
    }

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
