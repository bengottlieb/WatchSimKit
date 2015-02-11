//
//  WK_InterfaceStatusBar.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceStatusBar.h"
#import "WK_NavigationController.h"
#import "WK_Storyboard.h"

@interface WK_InterfaceStatusBar ()
@property (nonatomic, weak) WK_NavigationController *navigationController;
@end

@implementation WK_InterfaceStatusBar

+ (instancetype) statusBarInNavigationController: (WK_NavigationController *) nav {
	WK_InterfaceStatusBar	*bar = [self new];
	
	bar.showBackButton = false;
	bar.contentMode = UIViewContentModeRedraw;
	bar.userInteractionEnabled = true;
	bar.navigationController = nav;
	
	[bar addGestureRecognizer: [[UITapGestureRecognizer alloc] initWithTarget: bar action: @selector(tapped:)]];
	return bar;
}

- (void) tapped: (UITapGestureRecognizer *) recog {
	if (self.showBackButton) [self.navigationController popController];
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
	
	if (self.showBackButton) {
		UIImage			*image = [UIImage imageNamed: @"back_chevron" inBundle: [NSBundle bundleForClass: [self class]]	compatibleWithTraitCollection: nil];
		
		[image drawAtPoint: CGPointMake(4, 1)];
	}
}

- (void) setShowBackButton: (BOOL) showBackButton {
	_showBackButton = showBackButton;
	
	[self setNeedsDisplay];
}

@end
