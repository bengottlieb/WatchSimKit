//
//  WK_InterfaceLabel.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceLabel.h"
#import "WK_InterfaceController.h"

@interface WK_InterfaceLabel ()
@property (nonatomic, strong) UILabel *label;
@end

@implementation WK_InterfaceLabel

- (void) setText: (NSString *) text {
	self.label.text = text;
}

- (void) setTextColor: (UIColor *) color {
	self.label.textColor = color;
}

- (void) setAttributedText: (NSAttributedString *) string {
	self.label.attributedText = string;
}

- (UILabel *) label {
	if (_label == nil) {
		_label = [[UILabel alloc] initWithFrame: self.bounds];
		
		_label.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_label.font = [UIFont systemFontOfSize: 14];
		_label.textColor = [UIColor whiteColor];
		[self addSubview: _label];
	}
	return _label;
}

- (CGSize) contentSizeInSize: (CGSize) size {
	CGSize				labelSize = CGSizeZero;
	
	if (self.label.attributedText) {
		labelSize = [self.label.attributedText size];
	} else {
		labelSize = [self.label.text sizeWithAttributes: @{ NSFontAttributeName: self.label.font }];
	}
	
	return CGSizeMake(MIN(size.width, ceilf(labelSize.width)), MAX(18, ceilf(labelSize.height)));
}

- (void) loadFromDictionary: (NSDictionary *) dict {
	[super loadFromDictionary: dict];
	
	if (self.backgroundColor) {
		self.textColor = self.backgroundColor;
		self.backgroundColor = nil;
	}
	self.text = dict[@"text"][@"fallbackString"];
}

@end
