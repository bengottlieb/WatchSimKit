//
//  UIColor+Additions.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/5/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "UIColor+Additions.h"

@implementation UIColor (Additions)

+ (UIColor *) colorWithHexString: (NSString *) hex {
	unsigned int			colorValue = 0;
	
	if (hex == nil) return [UIColor clearColor];

	if ([hex isEqual: @"black"]) return [UIColor blackColor];
	
	NSScanner *scanner = [NSScanner scannerWithString: hex];
	[scanner scanHexInt: &colorValue];
	
	if (hex.length > 6)
		return [UIColor colorWithRed: ((colorValue >> 24) & 0xFF) / 255.0 green: ((colorValue >> 16) & 0xFF) / 255.0 blue: ((colorValue >> 8) & 0xFF) / 255.0 alpha: ((colorValue) & 0xFF) / 255.0];

	if (hex.length == 4)
		return [UIColor colorWithRed: ((colorValue >> 16) & 0xF0) / 255.0 green: ((colorValue >> 16) & 0x0F) / 255.0 blue: ((colorValue) & 0xF0) / 255.0 alpha: ((colorValue) & 0x0F) / 255.0];

	return [UIColor colorWithRed: ((colorValue >> 16) & 0xFF) / 255.0 green: ((colorValue >> 8) & 0xFF) / 255.0 blue: ((colorValue) & 0xFF) / 255.0 alpha: 1.0];
}

- (UIColor *) lightenBy: (CGFloat) percent {
	CGFloat				hue, sat, bri, alp;
	
	[self getHue: &hue saturation: &sat brightness: &bri alpha: &alp];
	
	return [UIColor colorWithHue: hue saturation: sat brightness: bri * (1 + percent) alpha: alp];
}

@end
