//
//  WatchSimViewController.m
//  WatchSim
//
//  Created by Ben Gottlieb on 2/10/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

#import "WK_SimViewController.h"
#import "WK_Storyboard.h"
#import "WK_InterfaceController.h"
#import "WK_NavigationController.h"

@interface WK_SimViewController ()
@property (nonatomic, weak) IBOutlet UIImageView *watchImageView;
@property (nonatomic, weak) IBOutlet UIView *watchDisplayView;
@property (nonatomic, strong) WK_NavigationController *watchInterface;
@property (nonatomic, weak) IBOutlet UIButton *scaleButton, *doneButton;
@property (nonatomic) CGFloat scale;
@end

@implementation WK_SimViewController

+ (instancetype) simController {
	WK_Storyboard		*munger = [WK_Storyboard storyboardWithFirstWatchKitExtension];
	WK_NavigationController	*interface = munger.navigationController;
	WK_SimViewController	*controller = [[self alloc] initWithNibName: NSStringFromClass(self) bundle: [NSBundle bundleForClass: [self class]]];
	
	controller.watchInterface = interface;
	controller.scale = 1.0;
	return controller;
}

- (void) viewDidLoad {
    [super viewDidLoad];
	
	[self.watchInterface setHostView: self.watchDisplayView];
	self.watchInterface.interfaceSize = WK_InterfaceSize_42mm;
}

- (IBAction) scaleButtonTouched: (UIButton *) sender {
	[sender setTitle: [NSString stringWithFormat: @"%.0fx", self.scale] forState: UIControlStateNormal];

	self.scale = (self.scale == 1.0) ? 2.0 : 1.0;
	
	[UIView animateWithDuration: 0.2 delay: 0.0 usingSpringWithDamping: 0.5 initialSpringVelocity: 0.0 options: UIViewAnimationOptionCurveEaseInOut animations:^{
		self.watchImageView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
		self.watchDisplayView.transform = CGAffineTransformMakeScale(self.scale, self.scale);
	} completion:^(BOOL finished) {
		
	}];
	
}

- (IBAction) doneButtonTouched: (UIButton *) sender {
	[self dismissViewControllerAnimated: true completion: nil];
}
@end
