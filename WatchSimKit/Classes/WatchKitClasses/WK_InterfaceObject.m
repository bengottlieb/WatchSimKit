//
//  WK_InterfaceObject.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceObject.h"
#import "WK_InterfaceLabel.h"
#import "WK_InterfaceGroup.h"
#import "WK_InterfaceButton.h"
#import "WK_InterfaceSeparator.h"
#import "WK_InterfaceController.h"
#import "WK_InterfaceImage.h"

@implementation WK_InterfaceObject

+ (WK_InterfaceObjectType) typeFromString: (NSString *) string {
	if ([string isEqual: @"group"]) return WK_InterfaceObjectType_group;
	if ([string isEqual: @"label"]) return WK_InterfaceObjectType_label;
	if ([string isEqual: @"button"]) return WK_InterfaceObjectType_button;
	if ([string isEqual: @"image"]) return WK_InterfaceObjectType_image;
	if ([string isEqual: @"separator"]) return WK_InterfaceObjectType_separator;
	
	return WK_InterfaceObjectType_none;
}

+ (instancetype) createWithDictionary: (NSDictionary *) info inController: (WK_InterfaceController *) controller {
	WK_InterfaceObject		*object = [[self alloc] initWithFrame: CGRectZero];
	
	object.interfaceController = controller;
	[object loadFromDictionary: info];
	return object;
}

+ (WK_InterfaceObject *) objectWithDictionary: (NSDictionary *) info inController: (WK_InterfaceController *) controller {	
	switch ([self typeFromString: info[@"type"]]) {
		case WK_InterfaceObjectType_label: return [WK_InterfaceLabel createWithDictionary: info inController: controller];
		case WK_InterfaceObjectType_group: return [WK_InterfaceGroup createWithDictionary: info inController: controller];
		case WK_InterfaceObjectType_button: return [WK_InterfaceButton createWithDictionary: info inController: controller];
		case WK_InterfaceObjectType_separator: return [WK_InterfaceSeparator createWithDictionary: info inController: controller];
		case WK_InterfaceObjectType_image: return [WK_InterfaceImage createWithDictionary: info inController: controller];
			
		default: break;
	}
	
	return nil;
}

- (void) setHidden: (BOOL) hidden {
	[super setHidden: hidden];
}

- (void) setAlpha: (CGFloat) alpha {
	[super setAlpha: alpha];
}

- (void) setWidth: (CGFloat) width {
	
}

- (void) setHeight: (CGFloat) height {
	
}

- (CGSize) contentSizeInSize: (CGSize) parentSize { return CGSizeZero; }

- (CGSize) actualSizeInSize: (CGSize) size {
	CGSize				contentSize = [self contentSizeInSize: size];

	if (!self.fitWidthToContent) {
		if (self.fixedWidth > 0 && self.fixedWidth <= 1.0) contentSize.width = size.width * self.fixedWidth;
		else if (self.fixedWidth != 0) contentSize.width = self.fixedWidth;
	}
	
	if (!self.fitHeightToContent) {
		if (self.fixedHeight > 0 && self.fixedHeight <= 1.0) contentSize.height = size.height * self.fixedHeight;
		else if (self.fixedHeight != 0) contentSize.height = self.fixedHeight;
	}
	
	return contentSize;
}

- (void) loadFromDictionary: (NSDictionary *) dict {
	self.interfaceDictionary = dict;
	if (dict[@"property"]) [self.interfaceController setValue: self forKey: dict[@"property"]];
	
	if (dict[@"height"])
		self.fixedHeight = [dict[@"height"] floatValue];
	else
		self.fitHeightToContent = true;
	
	if (dict[@"width"])
		self.fixedWidth = [dict[@"width"] floatValue];
	else
		self.fitWidthToContent = true;
	
	if (dict[@"color"]) self.backgroundColor = [UIColor colorWithHexString: dict[@"color"]];
}

- (void) setBackgroundImageName: (NSString *) backgroundImageName {
	self.backgroundImageView.image = [self.interfaceController imageNamed: backgroundImageName];
}

- (UIImageView *) backgroundImageView {
	if (_backgroundImageView == nil) {
		_backgroundImageView = [[UIImageView alloc] initWithFrame: self.bounds];
		_backgroundImageView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		[self insertSubview: _backgroundImageView atIndex: 0];
	}
	
	return _backgroundImageView;
}


@end
