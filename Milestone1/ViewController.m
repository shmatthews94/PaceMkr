//
//  ViewController.m
//  Milestone1
//
//  Created by Chase Deets on 10/20/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "ViewController.h"
#import "YouAreHereController.h"

@interface ViewController ()

@end

extern NSString *NameID;
extern NSString *Age;
extern NSString *THR;

@implementation ViewController

@synthesize Name;
@synthesize AgeText;

- (void)viewDidLoad {
    [super viewDidLoad];
    NameID = @"Name";
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendName:(id)sender {
    NameID = Name.text;
    Age = AgeText.text;
    int userage = [AgeText.text intValue];
    int hr = 220 - userage;
    hr = hr * .7;
    NSString* targetratestring = [NSString stringWithFormat:@"%i", hr];
    THR = targetratestring;
    YouAreHereController *herecontroller = [[YouAreHereController alloc] init];
    herecontroller.data = Name.text;
    [self.navigationController pushViewController:herecontroller animated:YES];
}
@end
