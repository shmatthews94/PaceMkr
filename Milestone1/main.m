//
//  main.m
//  Milestone1
//
//  Created by Chase Deets on 10/20/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

NSString *NameID;
NSString *Age;
NSString *THR;
NSDecimalNumber *TotalDistance;
CLLocation *Location1;
CLLocation *Location2;

int main(int argc, char * argv[]) {
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}
