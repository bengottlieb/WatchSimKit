//
//  WK_StoryboardMunger.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WK_InterfaceController, WK_InterfaceProfile, WK_NavigationController;

@interface WK_Storyboard : NSObject

@property (nonatomic, copy) NSString *storyboardPath;
@property (nonatomic, readonly) NSDictionary *controllers;
@property (nonatomic, readonly) NSBundle *bundle;
@property (nonatomic, strong) WK_NavigationController *navigationController;
@property (nonatomic, readonly) WK_InterfaceController *rootViewController;


+ (instancetype) storyboardWithFirstWatchKitExtension;

- (WK_InterfaceController *) controllerWithIdentifier: (NSString *) identifier;
- (WK_InterfaceProfile *) profileWithIdentifier: (NSString *) identifier;
@end
