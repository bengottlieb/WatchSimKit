//
//  InterfaceController.swift
//  WatchSim WatchKit Extension
//
//  Created by Ben Gottlieb on 2/15/15.
//  Copyright (c) 2015 Stand Alone, inc. All rights reserved.
//

import WatchKit
import Foundation

#if WATCH_SIM
	import WatchSimKit
	typealias WKInterfaceParent = WK_InterfaceController
#else
	typealias WKInterfaceParent = WKInterfaceController
#endif


class InterfaceController: WKInterfaceParent {
	@IBOutlet var table: WKInterfaceTable!
	
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
		self.table.setRowTypes(["myRowController", "myRowController"])
		
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
	
	

}


class TableRowController: NSObject {
	@IBOutlet var rowLabel: WKInterfaceLabel!
	@IBOutlet var rowButton: WKInterfaceButton!
	
	@IBAction func buttonTapped(sender: AnyObject?) {
		println("Button tapped")
	}
}