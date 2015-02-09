//
//  WK_InterfaceImage.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/7/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceImage.h"
#import "WK_InterfaceController.h"
#import "WK_InterfaceGroup.h"

@implementation WK_InterfaceImage

- (void) loadFromDictionary:(NSDictionary *)dict {
	[super loadFromDictionary: dict];
	self.backgroundImageName = dict[@"image"];
}

- (void) setImageNamed: (NSString *) imageName {
	self.backgroundImageName = imageName;
	[self.parentGroup objectChanged: self];
}

- (CGSize) contentSizeInSize: (CGSize) size {
	CGSize				buttonSize = self.backgroundImageView.image.size;
	
	return buttonSize;
}

@end
