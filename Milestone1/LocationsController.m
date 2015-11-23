//
//  LocationsController.m
//  PaceMkr
//
//  Created by Shane Matthews on 11/23/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import "LocationsController.h"

@interface LocationsController ()

@end

@implementation LocationsController

- (IBAction)fetchGreeting;
{
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:@"https://raw.githubusercontent.com/shmatthews94/PaceMkr/master/Milestone1/locations.json?token=AEYL7cAh2dvgSs_dnSRBEUgVUd1_kTLoks5WW_yrwA%3D%3D"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (data.length > 0 && error == nil)
                {
                    NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
                    for(id key in greeting) {
                        self.greetingContent.text = [self.greetingContent.text stringByAppendingString:[greeting objectForKey:key]];
                        
                    }
                    self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
                    //self.greetingContent.text = [greeting objectForKey:@"content"];
                }
                // handle response
                
            }] resume];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self fetchGreeting];
}

- (void)didReceiveMemoryWarning
{
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
