//
//  WK_InterfaceProfile.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/6/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceProfile.h"

@implementation WK_InterfaceProfile

+ (instancetype) compactInterfaceFromDictionary: (NSDictionary *) dict {
	return [self interfaceFromDictionary: dict ofType: @"compact"];
}

+ (instancetype) regularInterfaceFromDictionary: (NSDictionary *) dict {
	return [self interfaceFromDictionary: dict ofType: @"regular"];
}

+ (instancetype) interfaceFromDictionary: (NSDictionary *) dict ofType: (NSString *) type {
	WK_InterfaceProfile			*profile = [WK_InterfaceProfile new];
	
	if (dict[@"items"] != nil) dict = dict[@"items"];
	profile.items = @[];
	
	NSString			*imageKey = [NSString stringWithFormat: @"image-%@", type];
	NSString			*itemsKey = [NSString stringWithFormat: @"items-%@", type];
	
	for (NSDictionary *itemDict in dict) {
		if (itemDict[@"type"] != nil) {
			profile.items = [profile.items arrayByAddingObject: itemDict];
			continue;
		}
		if (itemDict[itemsKey]) profile.items = [profile.items arrayByAddingObject: [self groupWithItems: itemDict[itemsKey]]];
		if (itemDict[@"items"]) profile.items = [profile.items arrayByAddingObject: [self groupWithItems: itemDict[@"items"]]];
//		if (itemDict[itemsKey]) profile.items = [profile.items arrayByAddingObject: [self groupWithItems: itemDict[itemsKey]]];
//		if (itemDict[@"items"]) profile.items = [profile.items arrayByAddingObject: [self groupWithItems: itemDict[@"items"]]];
		if (itemDict[imageKey]) profile.imageName = itemDict[imageKey];
		if (itemDict[@"image"] && profile.imageName == nil) profile.imageName = itemDict[@"image"];
	}
	return profile;
}

+ (NSDictionary *) groupWithItems: (NSArray *) items {
	return @{ @"type": @"group", @"radius": @0, @"items": items, @"spacing": @1.0};
}

@end
