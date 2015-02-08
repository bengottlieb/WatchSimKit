//
//  WKInterfaceController.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WK_InterfaceGroup;

typedef NS_ENUM(NSUInteger, WK_InterfaceSize) {
	WK_InterfaceSize_none,
	WK_InterfaceSize_38mm,
	WK_InterfaceSize_42mm
};



@interface WKInterfaceController : UIView

+ (instancetype) controllerWithInterfaceDictionary: (NSDictionary *) interface inBundle: (NSBundle *) bundle;

- (UIImage *) imageNamed: (NSString *) name;

@property (nonatomic) WK_InterfaceSize interfaceSize;
@property (nonatomic) CGFloat scalingFactor;
@property (nonatomic, readonly) WK_InterfaceGroup *rootGroup;

- (void) awakeWithContext: (id) context;
- (void) willActivate;
- (void) didDeactivate;

@end
