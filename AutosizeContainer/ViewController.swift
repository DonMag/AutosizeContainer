//
//  ViewController.swift
//  AutosizeContainer
//
//  Created by Don Mag on 2/13/20.
//  Copyright © 2020 Don Mag. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

		@IBOutlet var theContainerView: UIView!
		
		// so we can reference the embedded VC
		var subVC: SubViewController?

		// this executes before viewDidLoad()
		override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
			if let vc = segue.destination as? SubViewController {
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

	class SubViewController: UIViewController {
		
		@IBOutlet var theStackView: UIStackView!

	}
