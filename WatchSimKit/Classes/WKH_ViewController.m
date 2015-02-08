//
//  ViewController.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WKH_ViewController.h"
#import "WK_StoryboardMunger.h"
#import "WKInterfaceController.h"

@interface WKH_ViewController ()
@property (nonatomic, strong) IBOutlet UIView *watchUIView;
@property (nonatomic, strong) IBOutlet WKInterfaceController *controllerView;
@end

@implementation WKH_ViewController

- (void) viewDidLayoutSubviews {
	if (self.controllerView == nil) {
		NSString				*path = [[NSBundle mainBundle] pathForResource: @"WatchedKitHarness WatchKit Extension" ofType: @"appex" inDirectory: @"PlugIns"];
		WK_StoryboardMunger		*munger = [WK_StoryboardMunger mungerWithAppExtensionPath: path];
		self.controllerView = munger.rootController;
		
		self.controllerView.interfaceSize = WK_InterfaceSize_42mm;
		self.controllerView.frame = self.watchUIView.bounds;
		[self.watchUIView addSubview: self.controllerView];
	}
	
}

@end
