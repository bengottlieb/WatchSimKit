//
//  WK_InterfaceTableCell.h
//  WatchSim
//
//  Created by Ben Gottlieb on 2/16/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WK_InterfaceProfile.h"
#import "WK_InterfaceController.h"

@interface WK_InterfaceTableCell : UITableViewCell

@property (nonatomic, strong) WK_InterfaceProfile *profile;
@property (nonatomic, readonly) CGFloat height;

- (void) setProfile: (WK_InterfaceProfile *) profile inController: (WK_InterfaceController *) controller;


@end
