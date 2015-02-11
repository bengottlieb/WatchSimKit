//
//  WK_StoryboardMunger.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/4/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_Storyboard.h"
#import "WK_InterfaceController.h"
#import "WK_NavigationController.h"

@interface WK_Storyboard ()
@property (nonatomic, strong) NSBundle *bundle;
@property (nonatomic, strong) NSDictionary *allControllers;
@end

@implementation WK_Storyboard

+ (instancetype) storyboardWithFirstWatchKitExtension {
	NSURL			*bundleURL = [NSBundle mainBundle].bundleURL;
	NSURL			*pluginURL = [bundleURL URLByAppendingPathComponent: @"PlugIns"];
	NSArray			*plugins = [[NSFileManager defaultManager] contentsOfDirectoryAtURL: pluginURL includingPropertiesForKeys: nil options: 0 error: nil];
	
	for (NSURL *url in plugins) {
		if ([url.pathExtension isEqual: @"app"] || [url.pathExtension isEqual: @"appex"]) return [self mungerWithAppExtensionURL: url];
	}
	return nil;
}

+ (instancetype) mungerWithAppExtensionURL: (NSURL *) url {
	NSArray			*items = [[NSFileManager defaultManager] contentsOfDirectoryAtURL: url includingPropertiesForKeys: nil options: 0 error: nil];
	
	for (NSURL *appPath in items) {
		if ([appPath.pathExtension isEqual: @"app"]) {
			return [[self alloc] initWithURL: appPath];
		}
	}

	return [[self alloc] initWithURL: url];
}

- (id) initWithURL: (NSURL *) url {
	if (self = [super init]) {
		NSBundle		*appBundle = [NSBundle bundleWithURL: url];
		NSString		*plistPath = [appBundle pathForResource: @"Interface" ofType: @"plist"];
		
		self.storyboardPath = plistPath;
		self.bundle = appBundle;
	}
	return self;
}

- (NSDictionary *) extractMainStoryboard {
	NSData					*data = [NSData dataWithContentsOfFile: self.storyboardPath];
	NSError					*error;
	NSDictionary			*dict = [NSPropertyListSerialization propertyListWithData: data options: 0 format: nil error: &error];
	
	return dict;
}

- (NSDictionary *) allControllers {
	if (_allControllers == nil) {
		NSMutableDictionary		*controllers = [NSMutableDictionary new];
		NSDictionary			*info = [self extractMainStoryboard];
	
		for (NSString *key in info[@"controllers"]) {
			NSDictionary	*controllerInfo = info[@"controllers"][key];
			NSString		*className = controllerInfo[@"controllerClass"];
			Class			class = NSClassFromString(className);
			
			if (class == nil) {
				className = [self demangleClassName: className];
				class = NSClassFromString(className);
			}
		
			if (class == nil) continue;
			
			WK_InterfaceController		*controller = [class controllerWithIdentifier: key andInterfaceDictionary: controllerInfo inNavigationController: self.navigationController];
			
			controllers[key] = controller;
		}
		_allControllers = controllers;
		
		[_allControllers[info[@"root"]] setIsRoot: YES];
	}
	return _allControllers;
}

- (WK_InterfaceController *) controllerWithIdentifier: (NSString *) identifier {
	return self.allControllers[identifier];
}

- (WK_InterfaceController *) rootViewController {
	for (WK_InterfaceController *controller in self.allControllers.allValues) {
		if (controller.isRoot) return controller;
	}
	return nil;
}

- (WK_NavigationController *) navigationController {
	if (_navigationController == nil) {
		_navigationController = [[WK_NavigationController alloc] initWithStoryboard: self];
	}
	return _navigationController;
}

- (NSString *) demangleClassName: (NSString *) name {
	//		_TtC36WatchedKitHarness_WatchKit_Extension19InterfaceController
	//		AAbCddE----------------------------------EffG-----------------G
	//		AA		standard prefix
	//		b		symbol type; t = type, F = function
	//		C		class/instance type
	//		dd		module name length
	//		E		module name
	//		ff		object name length
	//		G		object name
	
	if (![name hasPrefix: @"_T"]) { return name; }
	
	NSScanner		*parser = [NSScanner scannerWithString: name];
	NSString		*prefix = nil, *moduleName = nil;
	NSInteger		moduleNameLength = 0;
	NSInteger		classNameLength = 0;
	NSString		*className = nil;
	
	parser.charactersToBeSkipped = [NSCharacterSet characterSetWithCharactersInString: @"_"];
	
	NSCharacterSet	*numbers = [NSCharacterSet decimalDigitCharacterSet];
	NSCharacterSet	*alphas = [numbers invertedSet];
	
	
	
	[parser scanCharactersFromSet: alphas intoString: &prefix];
	[parser scanInteger: &moduleNameLength];
	[parser scanCharactersFromSet: alphas intoString: &moduleName];
	[parser scanInteger: &classNameLength];
	[parser scanCharactersFromSet: alphas intoString: &className];
	
	moduleName = [moduleName stringByReplacingOccurrencesOfString: @"_" withString: @""];
	NSString		*fullName = [moduleName stringByAppendingFormat: @".%@", className];
	
	if (NSClassFromString(fullName) != nil) { return fullName; }
	
	moduleName = [[NSBundle mainBundle] objectForInfoDictionaryKey: @"CFBundleExecutable"];
	return [moduleName stringByAppendingFormat: @".%@", className];
}


@end
