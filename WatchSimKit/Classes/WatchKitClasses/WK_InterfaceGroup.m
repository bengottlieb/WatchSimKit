//
//  WK_InterfaceGroup.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceGroup.h"
#import "WK_InterfaceController.h"
#import "WK_InterfaceSeparator.h"

@interface WK_InterfaceGroup ()
@property (nonatomic, strong) NSArray *items;
@property (nonatomic) CGFloat spacing, cornerRadius;
@property (nonatomic, strong) NSMutableArray *objects;
@end

@implementation WK_InterfaceGroup

- (void) loadItems: (NSArray *) items {
	self.items = items;
	
	for (UIView *view in self.objects) [view removeFromSuperview];
	self.objects = [NSMutableArray new];
	
	for (NSDictionary *item in self.items) {
		[self addItem: item];
	}
	
	[self setNeedsLayout];
}

- (void) loadFromDictionary: (NSDictionary *) dict {
	[super loadFromDictionary: dict];
	self.horizontalLayout = ![dict[@"layout"] isEqual: @"vertical"];
	
	self.spacing = (dict[@"spacing"]) ? [dict[@"spacing"] floatValue] : 2.0;
	self.cornerRadius = self.parentGroup.isRootGroup ? 6.0 : 0.0;
	if (dict[@"radius"]) self.cornerRadius = [dict[@"radius"] floatValue];
	
	self.layer.cornerRadius = self.cornerRadius;
	self.layer.masksToBounds = true;
	
	[self loadItems: dict[@"items"]];
	
}

- (void) addItem: (NSDictionary *) item {
	WK_InterfaceObject		*object = [WK_InterfaceObject objectWithDictionary: item inController: self.interfaceController];
	
	object.parentGroup = self;
	if (object == nil) return;
 
	if (self.objects == nil) self.objects = [NSMutableArray new];
	[self.objects addObject: object];
	[self addSubview: object];
}

- (void) layoutSubviews {
	[super layoutSubviews];
	
	[self layoutComponentsInRect: self.bounds];
}

- (CGSize) contentSizeInSize: (CGSize) parentSize {
	[self layoutComponentsInRect: CGRectMake(0, 0, parentSize.width, parentSize.height)];
	
	CGFloat				height = 0, width = 0;
	
	for (WK_InterfaceObject *object in self.objects) {
		CGRect			bounds = object.bounds;
		BOOL			isSeparator = [object isKindOfClass: [WK_InterfaceSeparator class]];
		CGFloat			spacing = (isSeparator ? 0 : self.spacing);
		
		if (self.horizontalLayout) {
			if (!isSeparator) height = MAX(CGRectGetHeight(bounds), height);
			width += CGRectGetWidth(bounds) + spacing;
		} else {
			height += CGRectGetHeight(bounds) + spacing;
			if (!isSeparator) width = MAX(CGRectGetWidth(bounds), width);
		}
	}
	
	if (self.horizontalLayout) {
		width -= self.spacing;
	} else {
		height -= self.spacing;
	}
	
	return CGSizeMake(width, height);
}

- (void) layoutComponentsInRect: (CGRect) rect {
	CGPoint			topLeft = CGPointZero;
	
	for (WK_InterfaceObject *object in self.objects) {
		CGSize			size = [object actualSizeInSize: rect.size];
		BOOL			isSeparator = [object isKindOfClass: [WK_InterfaceSeparator class]];
		CGFloat			spacing = (isSeparator ? 0 : self.spacing);
		
		size.width *= self.interfaceController.scalingFactor;
		size.height *= self.interfaceController.scalingFactor;
		
		CGRect				frame = CGRectMake(topLeft.x, topLeft.y, size.width, size.height);
		
	//	frame.size.width = MIN(frame.size.width, rect.size.width - frame.origin.x);
	//	frame.size.height = MIN(frame.size.height, rect.size.height - frame.origin.y);
		
		object.frame = frame;
		
		if (self.horizontalLayout) {
			topLeft.x += frame.size.width + spacing;
		} else {
			topLeft.y += frame.size.height + spacing;
		}
	}
}

- (void) objectChanged: (WK_InterfaceObject *) object {
	[self setNeedsLayout];
}

@end
