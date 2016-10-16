//
//  ViewController.swift
//  CardNavigation
//
//  Created by Mike Kavouras on 10/15/16.
//  Copyright © 2016 Mike Kavouras. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let cardTransitioningDelegate = CardTransitioningDelegate()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if let controller = storyboard?.instantiateViewController(withIdentifier: "DestinationSBIdentifier") as? DestinationViewController {
            controller.transitioningDelegate = cardTransitioningDelegate
            controller.modalPresentationStyle = .custom
            present(controller, animated: true)
        }
    }

}
