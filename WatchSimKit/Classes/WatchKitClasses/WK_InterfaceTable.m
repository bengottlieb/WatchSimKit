//
//  WK_InterfaceTable.m
//  WatchSim
//
//  Created by Ben Gottlieb on 2/16/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceTable.h"
#import "WK_InterfaceProfile.h"

#import "WK_InterfaceTableCell.h"

@interface WK_InterfaceTable () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableDictionary *standardRowControllers, *compactRowControllers;
@property (nonatomic, strong) NSMutableDictionary *cachedRowHeights;
@end

@implementation WK_InterfaceTable

- (void) loadFromDictionary: (NSDictionary *) dict {
	[super loadFromDictionary: dict];
	
	self.compactRowControllers = [NSMutableDictionary new];
	self.standardRowControllers = [NSMutableDictionary new];
	self.rowTypes = [NSMutableArray array];
	
	for (NSString *name in dict[@"rows"]) {
		self.compactRowControllers[name] = [WK_InterfaceProfile compactInterfaceFromDictionary: dict[@"rows"][name]];
		self.standardRowControllers[name] = [WK_InterfaceProfile regularInterfaceFromDictionary: dict[@"rows"][name]];
	}
	
	self.tableView = [[UITableView alloc] initWithFrame: self.bounds style: UITableViewStylePlain];
	[self.tableView registerClass: [WK_InterfaceTableCell class] forCellReuseIdentifier: @"row"];
	self.tableView.delegate = self;
	self.tableView.backgroundColor = [UIColor blackColor];
	self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
	self.tableView.dataSource = self;
	self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview: self.tableView];
}

- (CGSize) contentSizeInSize: (CGSize) size {
	size.height = 200;
	return size;
}

- (void) setRowTypes: (NSArray *) rowTypes {
	_rowTypes = rowTypes.mutableCopy;
	[self reloadData];
}

- (void) didMoveToSuperview {
	
}

- (void) reloadData {
	self.cachedRowHeights = [NSMutableDictionary new];
	[self.tableView reloadData];
}

//==========================================================================================
#pragma mark Table DataSource/Delegate
- (UITableViewCell *) tableView: (UITableView *) tableView cellForRowAtIndexPath: (NSIndexPath *) indexPath {
	WK_InterfaceTableCell *cell = (id) [tableView dequeueReusableCellWithIdentifier: @"row" forIndexPath: indexPath];
	
	[cell setProfile: self.standardRowControllers[self.rowTypes[indexPath.row]] inController: self.interfaceController];
	self.cachedRowHeights[indexPath] = @(cell.height);
	
	return cell;
}

- (NSInteger) numberOfSectionsInTableView: (UITableView *) tableView { return 1; }

- (NSInteger) tableView: (UITableView *) tableView numberOfRowsInSection: (NSInteger) section {	return self.rowTypes.count; }

- (void) tableView: (UITableView *) tableView didSelectRowAtIndexPath: (NSIndexPath *) indexPath {
	[tableView deselectRowAtIndexPath: indexPath animated: YES];
}

- (CGFloat) tableView: (UITableView *) tableView heightForRowAtIndexPath: (NSIndexPath *) indexPath {
	if (self.cachedRowHeights[indexPath]) return [self.cachedRowHeights[indexPath] floatValue];
	
	return 44.0;
}

@end
