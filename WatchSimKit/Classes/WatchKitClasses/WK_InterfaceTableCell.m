//
//  WK_InterfaceTableCell.m
//  WatchSim
//
//  Created by Ben Gottlieb on 2/16/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceTableCell.h"
#import "WK_InterfaceGroup.h"

static CGFloat s_tableRowSpacing = 6;

@interface WK_InterfaceTableCell ()
@property (nonatomic, strong) WK_InterfaceGroup *group;
@property (nonatomic, strong) WK_InterfaceController *interfaceController;
@property (nonatomic, strong) id <WK_ObjectOwner> rowController;
@end

@implementation WK_InterfaceTableCell

- (void) setProfile: (WK_InterfaceProfile *) profile inController: (WK_InterfaceController *) controller {
//	self.contentView.backgroundColor = [UIColor blackColor];
	self.interfaceController = controller;
	self.profile = profile;

//	self.rowController = [profile ];
	self.contentView.backgroundColor = [UIColor clearColor];
	self.backgroundColor = [UIColor clearColor];
	
	[self.group removeFromSuperview];
	
	self.group = [[WK_InterfaceGroup alloc] initWithFrame: CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height - s_tableRowSpacing)];
	self.group.interfaceController = self.interfaceController;

	self.group.owner = [profile rowController];
	[self.contentView addSubview: self.group];
	self.contentView.backgroundColor = self.group.backgroundColor;
	
	[self.group loadProfile: profile forInterfaceController: self.interfaceController];
}

- (CGFloat) height {
	CGSize			size = self.contentView.bounds.size;
	
	size.height = 1000;

	size = [self.group contentSizeInSize: size];
	
	return size.height + s_tableRowSpacing;
}

@end
