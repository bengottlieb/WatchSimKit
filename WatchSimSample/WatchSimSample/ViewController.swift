//
//  ViewController.swift
//  WatchSimSample
//
//  Created by Ben Gottlieb on 2/10/15.
//
//

import UIKit
import WatchSimKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		var controller = WK_SimViewController.simController()
		
		self.presentViewController(controller, animated: true, completion: nil)
	}

}

