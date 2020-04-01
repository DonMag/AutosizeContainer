//
//  Examples.swift
//  AutosizeContainer
//
//  Created by Don Mag on 4/1/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import UIKit

// MARK: Example 1

class Example1ViewController: UIViewController {
	
	@IBOutlet var theContainerView: UIView!
	
	// so we can reference the embedded VC
	var subVC: Example1SubViewController?
	
	// this executes before viewDidLoad()
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? Example1SubViewController {
			self.subVC = vc
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// make sure subVC was set correctly
		if let vc = self.subVC {
			// constrain child VC's view to container view
			vc.view.translatesAutoresizingMaskIntoConstraints = false
			NSLayoutConstraint.activate([
				vc.view.topAnchor.constraint(equalTo: theContainerView.topAnchor),
				vc.view.leadingAnchor.constraint(equalTo: theContainerView.leadingAnchor),
				vc.view.trailingAnchor.constraint(equalTo: theContainerView.trailingAnchor),
				
				// this will keep the container view's bottom equal to the child VC's view content
				theContainerView.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: 0.0),
			])
		}
		
	}
	
	@IBAction func showLabel(_ sender: Any) {
		if let vc = self.subVC {
			let views = vc.theStackView.arrangedSubviews
			for i in 0..<views.count {
				if views[i].isHidden {
					views[i].isHidden = false
					break
				}
			}
		}
	}
	
	@IBAction func hideLabel(_ sender: Any) {
		if let vc = self.subVC {
			let views = Array(vc.theStackView.arrangedSubviews.reversed())
			for i in 0..<views.count-1 {
				if !views[i].isHidden {
					views[i].isHidden = true
					break
				}
			}
		}
	}
	
}

class Example1SubViewController: UIViewController {
	
	@IBOutlet var theStackView: UIStackView!
	
}

// MARK: Example 2

class Example2ViewController: UIViewController {
	
	@IBOutlet var topContainerView: UIView!
	@IBOutlet var bottomContainerView: UIView!

	// so we can reference the embedded VC
	var topSubVC: Example2TopSubViewController?
	var botSubVC: Example2BottomSubViewController?

	// this executes before viewDidLoad()
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if let vc = segue.destination as? Example2TopSubViewController {
			topSubVC = vc
		}
		if let vc = segue.destination as? Example2BottomSubViewController {
			botSubVC = vc
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		// make sure subVCs were set correctly
		guard let topVC = topSubVC, let botVC = botSubVC,
			let topVCView = topVC.view, let botVCView = botVC.view
			else {
			fatalError("Something wrong with Container Views / embedded VCs setup.")
		}
		
		// a View Controller's "root" view loads with
		//		.translatesAutoresizingMaskIntoConstraints = true
		// but we want to let auto-layout change it
		topVCView.translatesAutoresizingMaskIntoConstraints = false
		botVCView.translatesAutoresizingMaskIntoConstraints = false

		NSLayoutConstraint.activate([
			
			// constrain all 4 sides of top view to top container
			//	because the Top container view has a Priority: 1000 height constraint,
			//	this will "fit" the top VC's view into the auto-layout sized top container
			topVCView.topAnchor.constraint(equalTo: topContainerView.topAnchor),
			topVCView.bottomAnchor.constraint(equalTo: topContainerView.bottomAnchor),
			topVCView.leadingAnchor.constraint(equalTo: topContainerView.leadingAnchor),
			topVCView.trailingAnchor.constraint(equalTo: topContainerView.trailingAnchor),
			
			// constrain all 4 sides of bottom view to bottom container
			//	because the Bottom container view has a Priority: 250 height constraint,
			//	the auto-layout height of the Bottom VC's view will determine the height of the bottom container
			botVCView.topAnchor.constraint(equalTo: bottomContainerView.topAnchor),
			botVCView.bottomAnchor.constraint(equalTo: bottomContainerView.bottomAnchor),
			botVCView.leadingAnchor.constraint(equalTo: bottomContainerView.leadingAnchor),
			botVCView.trailingAnchor.constraint(equalTo: bottomContainerView.trailingAnchor),
			
		])
		
	}
	
}

class Example2TopSubViewController: UIViewController {
	
}

class Example2BottomSubViewController: UIViewController {
	
}

