//
//  UIColor+Additions.h
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/5/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (Additions)

+ (UIColor *) colorWithHexString: (NSString *) hex;
- (UIColor *) lightenBy: (CGFloat) percent;
@end
