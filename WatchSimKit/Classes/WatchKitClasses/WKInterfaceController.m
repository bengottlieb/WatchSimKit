//
//  WKInterfaceController.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WKInterfaceController.h"
#import "WK_InterfaceGroup.h"
#import "WK_InterfaceProfile.h"

@interface WKInterfaceController ()
@property (nonatomic, strong) WK_InterfaceProfile *profile42, *profile38;
@property (nonatomic, strong) WK_InterfaceGroup *rootGroup;
@property (nonatomic, strong) NSBundle *bundle;
@end

@implementation WKInterfaceController

+ (instancetype) controllerWithInterfaceDictionary: (NSDictionary *) interface inBundle: (NSBundle *) bundle {
	WKInterfaceController			*controller = [[self alloc] initWithFrame: CGRectZero];
	
	controller.bundle = bundle;
	controller.layer.borderWidth = 0.5;
	controller.layer.borderColor = [UIColor lightGrayColor].CGColor;
	controller.backgroundColor = [UIColor blackColor];
	controller.scalingFactor = 1.0;
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
#pragma mark Properties

- (WK_InterfaceGroup *) rootGroup {
	if (_rootGroup == nil) {
		_rootGroup = [[WK_InterfaceGroup alloc] initWithFrame: self.bounds];
		_rootGroup.interfaceController = self;
		_rootGroup.isRootGroup = true;
		[self addSubview: _rootGroup];
	}
	return _rootGroup;
}

- (void) setInterfaceSize: (WK_InterfaceSize) interfaceSize {
	if (self.interfaceSize != WK_InterfaceSize_none) [self didDeactivate];
	_interfaceSize = interfaceSize;
	
	WK_InterfaceProfile	*profile = interfaceSize == WK_InterfaceSize_42mm ? self.profile42 : self.profile38;
	CGRect			frame = [WKInterfaceController boundsForSize: interfaceSize];
	
	frame.size.width *= self.scalingFactor;
	frame.size.height *= self.scalingFactor;
	
	self.bounds = frame;
	
	NSLog(@"42: %@", profile.items);
	[self.rootGroup loadItems: interfaceSize == WK_InterfaceSize_42mm ? profile.items : profile.items];
	self.rootGroup.backgroundImageName = profile.imageName;
}

- (UIImage *) imageNamed: (NSString *) name {
	if (name.length == 0) return nil;
	return [UIImage imageNamed: name inBundle: self.bundle compatibleWithTraitCollection: nil];
}


@end
