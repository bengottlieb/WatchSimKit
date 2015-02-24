//
//  WK_InterfaceProfile.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/6/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@class WK_InterfaceController;

@interface WK_InterfaceProfile : NSObject

+ (instancetype) interfaceWithIdentifier: (NSString *) identifier fromDictionary: (NSDictionary *) dict;

- (NSDictionary *) dictionaryForController: (WK_InterfaceController *) controller;

@property (nonatomic) BOOL isRoot;
@property (nonatomic, readonly) NSString *identifier;
@property (nonatomic, readonly) Class controllerClass;
@property (nonatomic, readonly) id rowController;
@property (nonatomic, readonly) NSDictionary *interfaceDictionary;

@end


@interface NSDictionary (WK_WatchSimKit)
- (id) objectForKey: (id) aKey inController: (WK_InterfaceController *) controller;
@end
