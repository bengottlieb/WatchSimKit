//
//  WatchSimViewController.m
//  WatchSim
//
//  Created by Ben Gottlieb on 2/10/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_SimViewController.h"
#import "WK_StoryboardMunger.h"
#import "WK_InterfaceController.h"

@interface WK_SimViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *watchImageView;
@property (nonatomic, weak) IBOutlet UIView *watchDisplayView;
@property (nonatomic, strong) WK_InterfaceController *watchInterface;
@end

@implementation WK_SimViewController

+ (instancetype) simController {
	WK_StoryboardMunger		*munger = [WK_StoryboardMunger mungerWithFirstWatchKitExtension];
	WK_InterfaceController	*interface = munger.rootController;
	
	if (interface != nil) {
		WK_SimViewController		*controller = [[self alloc] initWithNibName: NSStringFromClass(self) bundle: [NSBundle bundleForClass: [self class]]];
		
		controller.watchInterface = interface;
		return controller;
	}
	return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.watchInterface.frame = self.watchDisplayView.bounds;
	[self.watchDisplayView addSubview: self.watchInterface];
	self.watchInterface.interfaceSize = WK_InterfaceSize_42mm;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
