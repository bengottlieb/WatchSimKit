//
//  WS_ViewController.m
//  WatchSim
//
//  Created by Ben Gottlieb on 2/7/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WS_ViewController.h"
#import <WatchSimKit/WatchSimKit.h>

@interface WS_ViewController ()

@end

@implementation WS_ViewController

- (void) viewDidAppear: (BOOL) animated {
	[super viewDidAppear: animated];
	
	[self presentViewController: [WK_SimViewController simController] animated: true completion: nil];
}

@end
