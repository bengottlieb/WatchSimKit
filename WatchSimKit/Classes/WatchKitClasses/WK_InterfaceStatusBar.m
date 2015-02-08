//
//  WK_InterfaceStatusBar.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceStatusBar.h"

@implementation WK_InterfaceStatusBar

+ (instancetype) statusBar {
	WK_InterfaceStatusBar	*bar = [self new];
	
	bar.contentMode = UIViewContentModeRedraw;
	return bar;
}

- (CGSize) contentSizeInSize: (CGSize) size {
	return CGSizeMake(size.width, 20);
}

- (void) drawRect: (CGRect) rect {
	CGRect			bounds = self.bounds;
	NSString		*text = @"12:00";
	UIFont			*font= [UIFont systemFontOfSize: 17];
	NSDictionary	*attr = @{ NSFontAttributeName: font, NSForegroundColorAttributeName: [UIColor grayColor] };
	CGSize			size = [text sizeWithAttributes: attr];
	
	[text drawInRect: CGRectMake(bounds.size.width - size.width, 0, size.width, size.height) withAttributes: attr];
}


@end
