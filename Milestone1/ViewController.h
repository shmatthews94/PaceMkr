//
//  ViewController.h
//  Milestone1
//
//  Created by Chase Deets on 10/20/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
- (IBAction)sendName:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *Name;
@property (weak, nonatomic) IBOutlet UITextField *AgeText;



@end

