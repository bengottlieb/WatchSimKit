//
//  WK_InterfaceProfile.m
//  WatchSimKit
//
//  Created by Ben Gottlieb on 2/6/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_InterfaceProfile.h"
#import "WK_NavigationController.h"
#import "WK_InterfaceController.h"

@interface WK_InterfaceProfile ()
@property (nonatomic, assign) Class controllerClass;
@property (nonatomic, strong) NSString *identifier;
@property (nonatomic, strong) NSDictionary *interfaceDictionary;

@property (nonatomic, strong) NSArray *compactItems, *regularItems;
@property (nonatomic, strong) NSString *compactImageName, *regularImageName;
@property (nonatomic, strong) id rowController;

@end

@implementation WK_InterfaceProfile

+ (instancetype) interfaceWithIdentifier: (NSString *) identifier fromDictionary: (NSDictionary *) dict {
	NSString		*className = dict[@"controllerClass"];
	Class			class = NSClassFromString(className);
	
	if (class == nil) {
		className = [self demangleClassName: className];
		class = NSClassFromString(className);
	}
	
	if (class == nil) return nil;
	
	WK_InterfaceProfile		*profile = [self new];
	
	profile.identifier = identifier;
	profile.controllerClass = class;
	profile.interfaceDictionary = dict;
	return profile;
}

- (WK_InterfaceController *) controllerInNavigationController: (WK_NavigationController *) navController {
	WK_InterfaceController		*controller = [self.controllerClass controllerWithProfile: self inNavigationController: navController];

	return controller;
}

+ (NSString *) demangleClassName: (NSString *) name {
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

- (NSDictionary *) dictionaryForController: (WK_InterfaceController *) controller {
	NSMutableDictionary			*info = @{}.mutableCopy;
	
	for (NSString *key in self.interfaceDictionary) {
		NSArray		*components = [key componentsSeparatedByString: @"-"];
		
		if (components.count == 1 || [components.lastObject isEqual: controller.interfaceSizeString]) {
			info[components[0]] = self.interfaceDictionary[key];
		}
	}

	return info;
}

- (id) rowController {
	if (_rowController == nil) {
		_rowController = [self.controllerClass new];
	}
	return _rowController;
}

@end


@implementation NSDictionary (WK_WatchSimKit)
- (id) objectForKey: (id) aKey inController: (WK_InterfaceController *) controller {
	NSString		*specificKey = [NSString stringWithFormat: @"%@-%@", aKey, controller.interfaceSizeString];
	
	return self[specificKey] ?: self[aKey];
}
@end
