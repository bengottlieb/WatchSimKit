//
//  WK_InterfaceSeparator.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/7/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceSeparator.h"
#import "WK_InterfaceGroup.h"

@implementation WK_InterfaceSeparator

- (CGSize) contentSizeInSize: (CGSize) parentSize {
	if (self.parentGroup.horizontalLayout) {
		return CGSizeMake(self.fixedHeight, parentSize.height);
	}
	return CGSizeMake(parentSize.width, self.fixedHeight);
}

@end
