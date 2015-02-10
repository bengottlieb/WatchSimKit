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
@property (nonatomic, weak) IBOutlet UIButton *scaleButton, *doneButton;
@property (nonatomic) CGFloat scale;
@end

@implementation WK_SimViewController

+ (instancetype) simController {
	WK_StoryboardMunger		*munger = [WK_StoryboardMunger mungerWithFirstWatchKitExtension];
	WK_InterfaceController	*interface = munger.rootController;
	WK_SimViewController	*controller = [[self alloc] initWithNibName: NSStringFromClass(self) bundle: [NSBundle bundleForClass: [self class]]];
	
	controller.watchInterface = interface;
	controller.scale = 1.0;
	return controller;
}

- (void) viewDidLoad {
    [super viewDidLoad];
	
	self.watchInterface.frame = self.watchDisplayView.bounds;
	[self.watchDisplayView addSubview: self.watchInterface];
	self.watchInterface.interfaceSize = WK_InterfaceSize_42mm;
}

- (IBAction) scaleButtonTouched: (UIButton *) sender {
	[sender setTitle: [NSString stringWithFormat: @"%.0fx", self.scale] forState: UIControlStateNormal];

	self.scale = (self.scale == 1.0) ? 2.0 : 1.0;
	
	self.watchImageView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
	self.watchDisplayView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
	
}

- (IBAction) doneButtonTouched: (UIButton *) sender {
	[self dismissViewControllerAnimated: true completion: nil];
}
@end
