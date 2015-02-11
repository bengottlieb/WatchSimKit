//
//  WK_NavigationController.h
//  WatchSim
//
//  Created by Ben Gottlieb on 2/11/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, WK_InterfaceSize) {
	WK_InterfaceSize_none,
	WK_InterfaceSize_38mm,
	WK_InterfaceSize_42mm
};

@class WK_Storyboard, WK_InterfaceController;

@interface WK_NavigationController : UIView

@property (nonatomic) WK_InterfaceSize interfaceSize;
@property (nonatomic, readonly) WK_Storyboard *storyboard;
@property (nonatomic, strong) WK_InterfaceController *rootViewController;
@property (nonatomic, readonly) WK_InterfaceController *topController;

- (id) initWithStoryboard: (WK_Storyboard *) storyboard;
- (void) setHostView: (UIView *) view;

- (void) pushControllerWithName: (NSString *) name context: (id) context;
- (void) popController;
- (void) popToRootController;


@end
