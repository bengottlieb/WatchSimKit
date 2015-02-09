//
//  WK_InterfaceObject.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIColor+Additions.h"


typedef NS_ENUM(NSUInteger, WK_InterfaceObjectType) {
	WK_InterfaceObjectType_none,
	WK_InterfaceObjectType_group,
	WK_InterfaceObjectType_label,
	WK_InterfaceObjectType_button,
	WK_InterfaceObjectType_image,
	WK_InterfaceObjectType_separator
};

@class WK_InterfaceController, WK_InterfaceGroup;

@interface WK_InterfaceObject : UIView

+ (WK_InterfaceObjectType) typeFromString: (NSString *) string;
+ (WK_InterfaceObject *) objectWithDictionary: (NSDictionary *) info inController: (WK_InterfaceController *) controller;;
+ (instancetype) createWithDictionary: (NSDictionary *) info inController: (WK_InterfaceController *) controller;

- (void) setHidden: (BOOL) hidden;
- (void) setAlpha: (CGFloat) alpha;

- (void) setWidth: (CGFloat) width;
- (void) setHeight: (CGFloat) height;


@property (nonatomic) CGFloat fixedHeight, fixedWidth;
@property (nonatomic) BOOL fitHeightToContent, fitWidthToContent;
@property (nonatomic, weak) WK_InterfaceController *interfaceController;
@property (nonatomic, strong) NSDictionary *interfaceDictionary;
@property (nonatomic, weak) WK_InterfaceGroup *parentGroup;
@property (nonatomic, strong) UIImageView *backgroundImageView;
@property (nonatomic, strong) NSString *backgroundImageName;

- (CGSize) contentSizeInSize: (CGSize) parentSize;
- (CGSize) actualSizeInSize: (CGSize) size;
- (void) loadFromDictionary: (NSDictionary *) dict;

@end
