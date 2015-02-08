//
//  WK_InterfaceGroup.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceObject.h"

@interface WK_InterfaceGroup : WK_InterfaceObject

@property (nonatomic) BOOL isRootGroup;
@property (nonatomic) BOOL horizontalLayout;

- (void) loadItems: (NSArray *) items;

@end
