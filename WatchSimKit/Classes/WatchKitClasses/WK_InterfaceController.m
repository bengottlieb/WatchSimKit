//
//  WK_InterfaceController.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceController.h"
#import "WK_InterfaceGroup.h"
#import "WK_InterfaceProfile.h"
#import "WK_Storyboard.h"
#import "WK_NavigationController.h"

@interface WK_InterfaceController () <WK_ObjectOwner>
@property (nonatomic, strong) WK_InterfaceProfile *profile42, *profile38;
@property (nonatomic, strong) WK_InterfaceGroup *rootGroup;
@property (nonatomic, strong) WK_NavigationController *navigationController;
@property (nonatomic, strong) WK_InterfaceController *parentController;

@end

@implementation WK_InterfaceController

+ (instancetype) controllerWithIdentifier: (NSString *) ident andInterfaceDictionary: (NSDictionary *) interface inNavigationController: (WK_NavigationController *) nav {
	WK_InterfaceController			*controller = [[self alloc] initWithFrame: CGRectZero];
	
	controller.navigationController = nav;
	controller.scalingFactor = 1.0;
	controller.identifier = ident;
	controller.profile42 = [WK_InterfaceProfile regularInterfaceFromDictionary: interface];
	controller.profile38 = [WK_InterfaceProfile compactInterfaceFromDictionary: interface];
	
	return controller;
}

+ (CGRect) boundsForSize: (WK_InterfaceSize) size {
	switch (size) {
		case WK_InterfaceSize_none: return CGRectZero;
		case WK_InterfaceSize_38mm: return CGRectMake(0, 0, 272 / 2, 340 / 2);
		case WK_InterfaceSize_42mm: return CGRectMake(0, 0, 312 / 2, 390 / 2);
	}
}

- (void) awakeWithContext: (id) context {
	
}

- (void) willActivate {
	
}

- (void) didDeactivate {
	
}

//================================================================================================================
#pragma mark Navigation
- (void) pushControllerWithName: (NSString *) name context: (id) context {
	[self.navigationController pushControllerWithName: name context: context];
}

- (void) popController {
	[self.navigationController popController];
}

- (void) popToRootController {
	[self.navigationController popToRootController];
}

- (void)presentControllerWithName:(NSString *)name context:(id)context {
	
}

- (void)dismissController {
	
}

- (id) contextForSegueWithIdentifier: (NSString *) segueIdentifier { return nil; }


//================================================================================================================
#pragma mark Properties

- (WK_InterfaceGroup *) rootGroup {
	if (_rootGroup == nil) {
		_rootGroup = [[WK_InterfaceGroup alloc] initWithFrame: self.bounds];
		_rootGroup.interfaceController = self;
		_rootGroup.owner = self;
		_rootGroup.isRootGroup = true;
		[self addSubview: _rootGroup];
	}
	return _rootGroup;
}

- (void) setInterfaceSize: (WK_InterfaceSize) interfaceSize {
	if (interfaceSize == WK_InterfaceSize_none) return;
	
	if (self.interfaceSize != WK_InterfaceSize_none) [self didDeactivate];
	_interfaceSize = interfaceSize;
	
	WK_InterfaceProfile	*profile = interfaceSize == WK_InterfaceSize_42mm ? self.profile42 : self.profile38;
	CGRect			frame = [WK_InterfaceController boundsForSize: interfaceSize];
	
	frame.size.width *= self.scalingFactor;
	frame.size.height *= self.scalingFactor;
	
	[self.rootGroup removeFromSuperview];
	self.rootGroup = nil;
	
	self.bounds = frame;
	
	//NSLog(@"42: %@", profile.items);
	[self.rootGroup loadProfile: profile];

	[self awakeWithContext: nil];
	[self willActivate];
}

- (UIImage *) imageNamed: (NSString *) name {
	return [self.navigationController imageNamed: name];
}


@end
