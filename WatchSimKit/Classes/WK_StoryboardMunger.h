//
//  WK_StoryboardMunger.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WKInterfaceController;

@interface WK_StoryboardMunger : NSObject

@property (nonatomic, copy) NSString *storyboardPath;
@property (nonatomic, readonly) WKInterfaceController *rootController;

+ (instancetype) mungerWithAppExtensionPath: (NSString *) path;

@end
