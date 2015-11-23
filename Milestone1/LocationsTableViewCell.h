//
//  LocationsTableViewCell.h
//  PaceMkr
//
//  Created by Shane Matthews on 11/23/15.
//  Copyright © 2015 Chane Meets. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LocationsTableViewCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *namelabel;
@property (nonatomic, weak) IBOutlet UILabel *latlabel;
@property (nonatomic, weak) IBOutlet UILabel *distancelabel;

@end
