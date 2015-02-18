//
//  WK_InterfaceController.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WK_NavigationController.h"

@class WK_InterfaceGroup, WK_NavigationController, WK_InterfaceProfile;
@protocol WK_ObjectOwner;

@interface WK_InterfaceController : UIView

+ (instancetype) controllerWithProfile: (WK_InterfaceProfile *) profile inNavigationController: (WK_NavigationController *) nav;
+ (CGRect) boundsForSize: (WK_InterfaceSize) size;

- (UIImage *) imageNamed: (NSString *) name;

@property (nonatomic) WK_InterfaceSize interfaceSize;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic) CGFloat scalingFactor;
@property (nonatomic, readonly) WK_InterfaceGroup *rootGroup;
@property (nonatomic) BOOL isRoot;
@property (nonatomic, readonly) WK_NavigationController *navigationController;
@property (nonatomic, readonly) WK_InterfaceController *rootController, *parentController;

- (void) awakeWithContext: (id) context;
- (void) willActivate;
- (void) didDeactivate;

- (void) pushControllerWithName: (NSString *) name context: (id) context;
- (void) popController;
- (void) popToRootController;

- (void)presentControllerWithName:(NSString *)name context:(id)context; // modal presentation
- (void)dismissController;

- (id) contextForSegueWithIdentifier: (NSString *) segueIdentifier;

@end
