//
//  WK_InterfaceButton.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceButton.h"
#import "WK_InterfaceController.h"
#import "WK_InterfaceGroup.h"

@interface WK_InterfaceButton ()
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UIImage *backgroundImage;
@end

@implementation WK_InterfaceButton

- (void) setTitle: (NSString *) text {
	[self.button setTitle: text forState: UIControlStateNormal];
}

- (void) setTextColor: (UIColor *) color {
	[self.button setTitleColor: color forState: UIControlStateNormal];
}

- (void) setAttributedTitle: (NSAttributedString *) string {
	[self.button setAttributedTitle: string forState: UIControlStateNormal];
}

- (void) setBackgroundImage: (UIImage *) image {
	_backgroundImage = image;
	if (image) {
		_button.adjustsImageWhenHighlighted = true;
		self.layer.cornerRadius = 0;
	} else {
		_button.showsTouchWhenHighlighted = true;
		self.layer.cornerRadius = 6.0;
	}
	[self.button setBackgroundImage: image forState: UIControlStateNormal];
}

- (void) setBackgroundImageNamed: (NSString *) imageName {
	[self setBackgroundImage: [self.interfaceController imageNamed: imageName]];
	[self.parentGroup objectChanged: self];
}

- (UIButton *) button {
	if (_button == nil) {
		_button = [UIButton buttonWithType: UIButtonTypeCustom];
		
		_button.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
		_button.showsTouchWhenHighlighted = true;
		_button.titleLabel.font = [UIFont systemFontOfSize: 14];
		_button.backgroundColor = [UIColor colorWithWhite: 0.9 alpha: 0.2];
		[_button addTarget: self action: @selector(buttonPressed:) forControlEvents: UIControlEventTouchUpInside];
		[self addSubview: _button];
	}
	return _button;
}

- (void) buttonPressed: (UIButton *) sender {
	if (self.interfaceDictionary[@"action"]) {
		[self.button addTarget: self.interfaceController action: NSSelectorFromString(self.interfaceDictionary[@"action"]) forControlEvents:UIControlEventTouchUpInside];
	} else if (self.interfaceDictionary[@"segue"]) {
		[self.interfaceController pushControllerWithName: self.interfaceDictionary[@"segue"][@"destination"] context: nil];
	}
}

- (CGSize) contentSizeInSize: (CGSize) size {
	CGSize				buttonSize = self.backgroundImage.size;
	
	if (!self.fitWidthToContent) buttonSize.width = self.fixedWidth ? self.fixedWidth / self.interfaceController.scalingFactor : size.width;
	if (!self.fitHeightToContent || buttonSize.height == 0) buttonSize.height = 38 / self.interfaceController.scalingFactor;
	
	if (self.backgroundImage) {
		buttonSize.height = self.backgroundImage.size.height / self.interfaceController.scalingFactor;
	}
	
	return buttonSize;
}

- (void) loadFromDictionary: (NSDictionary *) dict {
	[super loadFromDictionary: dict];
	
	self.layer.cornerRadius = 6.0;
	self.layer.masksToBounds = true;
	self.title = dict[@"title"][@"fallbackString"];
	if (dict[@"titleColor"]) self.textColor = [UIColor colorWithHexString: dict[@"titleColor"]];
	if (dict[@"image"]) [self setBackgroundImageNamed: dict[@"image"]];
}

@end
