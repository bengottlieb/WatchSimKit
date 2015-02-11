//
//  WK_NavigationController.m
//  WatchSim
//
//  Created by Ben Gottlieb on 2/11/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_NavigationController.h"
#import "WK_Storyboard.h"
#import "WK_InterfaceController.h"


@interface WK_NavigationController ()
@property (nonatomic, strong) WK_Storyboard *storyboard;
@property (nonatomic, strong) NSMutableArray *controllers;
@property (nonatomic, strong) WK_InterfaceController *topController;
@end

@implementation WK_NavigationController

- (id) initWithStoryboard: (WK_Storyboard *) storyboard {
	if (self = [super initWithFrame: CGRectZero]) {
		self.storyboard = storyboard;
		self.controllers = [NSMutableArray new];

		self.layer.borderWidth = 0.5;
		self.layer.borderColor = [UIColor lightGrayColor].CGColor;
		self.backgroundColor = [UIColor blackColor];

		UISwipeGestureRecognizer			*swipe = [[UISwipeGestureRecognizer alloc] initWithTarget: self action: @selector(popController)];
		swipe.direction = UISwipeGestureRecognizerDirectionRight;
		[self addGestureRecognizer: swipe];
	}
	return self;
}

- (void) setRootViewController: (WK_InterfaceController *) rootViewController {
	if (rootViewController != _rootViewController) {
		self.controllers = rootViewController ? @[ rootViewController ].mutableCopy : [NSMutableArray new];
		if (_rootViewController) [self.controllers removeObject: _rootViewController];
		[_rootViewController removeFromSuperview];
		_rootViewController = rootViewController;
		rootViewController.frame = self.bounds;
		rootViewController.interfaceSize = self.interfaceSize;
		[self addSubview: rootViewController];
		self.topController = rootViewController;
	}
}

- (void) setHostView: (UIView *) view {
	self.frame = view.bounds;
	self.rootViewController = self.storyboard.rootViewController;
	[view addSubview: self];
}

- (void) setInterfaceSize: (WK_InterfaceSize) interfaceSize {
	_interfaceSize = interfaceSize;
	
	self.bounds = [WK_InterfaceController boundsForSize: interfaceSize];
	
	for (WK_InterfaceController *controller in self.controllers) {
		controller.interfaceSize = interfaceSize;
	}
}


//================================================================================================================
#pragma mark Navigation

- (void) pushControllerWithName: (NSString *) name context: (id) context {
	WK_InterfaceController		*next = [self.storyboard controllerWithIdentifier: name];
	CGPoint						center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
	
	if (next == nil) {
		NSLog(@"Couldn't find a controller matching identifier: %@", name);
		return;
	}
	
	next.frame = self.bounds;
	next.interfaceSize = self.interfaceSize;
	next.center = center;
	next.transform = CGAffineTransformMakeScale(0.1, 0.1);
	next.alpha = 0.0;
	[self insertSubview: next belowSubview: self.topController];
	
	[UIView animateWithDuration: 0.5 delay: 0.0 usingSpringWithDamping: 1.0 initialSpringVelocity: 0.0 options: UIViewAnimationOptionCurveEaseOut animations:^{
		self.topController.center = CGPointMake(self.bounds.size.width * -0.5, self.bounds.size.height * 0.5);;
		next.transform = CGAffineTransformIdentity;
		next.alpha = 1.0;
		self.topController.alpha = 0.0;
	} completion: ^(BOOL finished) {
		[self.topController removeFromSuperview];
		[self.controllers addObject: next];
		self.topController = next;
	}];
}

- (void) popController {
	if (self.controllers.count < 2) return;
	WK_InterfaceController		*next = self.controllers[self.controllers.count - 2];
	CGPoint						center = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
	
	next.center = CGPointMake(self.bounds.size.width * -0.5, self.bounds.size.height * 0.5);
	[self insertSubview: next belowSubview: self.topController];
	next.alpha = 0.0;
	
	[UIView animateWithDuration: 0.5 delay: 0.0 usingSpringWithDamping: 1.0 initialSpringVelocity: 0.0 options: UIViewAnimationOptionCurveEaseOut animations: ^{
		self.topController.alpha = 0.0;
		self.topController.transform = CGAffineTransformMakeScale(0.1, 0.1);
		next.center = center;
		next.alpha = 1.0;
	} completion: ^(BOOL finished) {
		[self.topController removeFromSuperview];
		[self.controllers removeObject: self.topController];
		self.topController = next;
	}];
}

- (void) popToRootController {
	
}



@end
