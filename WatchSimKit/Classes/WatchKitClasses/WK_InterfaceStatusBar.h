//
//  WK_InterfaceStatusBar.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceObject.h"
#import "WK_NavigationController.h"

@interface WK_InterfaceStatusBar : WK_InterfaceObject
+ (instancetype) statusBarInNavigationController: (WK_NavigationController *) nav;

@property (nonatomic) BOOL showBackButton;

@end
