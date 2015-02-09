//
//  ViewController.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WKH_ViewController.h"
#import "WK_StoryboardMunger.h"
#import "WK_InterfaceController.h"

@interface WKH_ViewController ()
@property (nonatomic, strong) IBOutlet UIView *watchUIView;
@property (nonatomic, strong) IBOutlet WK_InterfaceController *controllerView;
@end

@implementation WKH_ViewController

- (void) viewDidLayoutSubviews {
	if (self.controllerView == nil) {
		WK_StoryboardMunger		*munger = [WK_StoryboardMunger mungerWithFirstWatchKitExtension];
		self.controllerView = munger.rootController;
		
		self.controllerView.interfaceSize = WK_InterfaceSize_42mm;
		self.controllerView.frame = self.watchUIView.bounds;
		[self.watchUIView addSubview: self.controllerView];
	}
	
}

@end
