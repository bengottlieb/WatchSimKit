//
//  WK_InterfaceImage.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/7/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceImage.h"
#import "WKInterfaceController.h"

@implementation WK_InterfaceImage

- (void) loadFromDictionary:(NSDictionary *)dict {
	self.backgroundImageName = dict[@"image"];
}

- (CGSize) contentSizeInSize: (CGSize) size {
	CGSize				buttonSize = self.backgroundImageView.image.size;
	
	return buttonSize;
}

@end
