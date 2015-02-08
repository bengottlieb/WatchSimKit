//
//  WK_InterfaceLabel.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceObject.h"

@interface WK_InterfaceButton : WK_InterfaceObject

- (void) setText: (NSString *) text;
- (void) setTextColor: (UIColor *) color;
- (void) setAttributedText: (NSAttributedString *) string;


@end
