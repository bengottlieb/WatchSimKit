//
//  InterfaceController.swift
//  WatchSimSample WatchKit Extension
//
//  Created by Ben Gottlieb on 2/10/15.
//
//

import Foundation
import WatchKit


#if WATCH_SIM
	import WatchSimKit
	typealias WKInterfaceParent = WK_InterfaceController
#else
	typealias WKInterfaceParent = WKInterfaceController
#endif

	
class InterfaceController: WKInterfaceParent {
	var timer: NSTimer?
	@IBOutlet var button: WKInterfaceButton!
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
		
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
		self.timer = NSTimer.scheduledTimerWithTimeInterval(0.5, target: self, selector: "timerFired", userInfo: nil, repeats: true)
        super.willActivate()
    }

    override func didDeactivate() {
		self.timer?.invalidate()
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
	
	func timerFired() {
		var text = "\(NSDate())"
		var items = text.componentsSeparatedByString(" ")
		self.button?.setTitle(items[1])
	}
	
	@IBAction func buttonPressed() {
		self.button?.setTitle("Tick")
	}

}
