//
//  InterfaceController.swift
//  WatchSimSample WatchKit Extension
//
//  Created by Ben Gottlieb on 2/10/15.
//
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
	var timer: NSTimer?
	@IBOutlet var label: WKInterfaceLabel!
	
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
		self.label.setText(items[1])
	}
	
	@IBAction func buttonPressed() {
		self.label.setText("Tick")
	}

}
