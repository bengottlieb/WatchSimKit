//
//  WK_InterfaceProfile.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/6/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WK_InterfaceProfile : NSObject

+ (instancetype) compactInterfaceFromDictionary: (NSDictionary *) dict;
+ (instancetype) regularInterfaceFromDictionary: (NSDictionary *) dict;


@property (nonatomic, strong) NSArray *items;
@property (nonatomic, strong) NSString *imageName;
@end
