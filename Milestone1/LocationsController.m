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
    [[session dataTaskWithURL:[NSURL URLWithString:@"http://rest-service.guides.spring.io/greeting"]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                if (data.length > 0 && error == nil)
                {
                    NSDictionary *greeting = [NSJSONSerialization JSONObjectWithData:data
                                                                             options:0
                                                                               error:NULL];
                    self.greetingId.text = [[greeting objectForKey:@"id"] stringValue];
                    self.greetingContent.text = [greeting objectForKey:@"content"];
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
