//
//  CardAnimationController.swift
//  CardNavigation
//
//  Created by Mike Kavouras on 10/15/16.
//  Copyright © 2016 Mike Kavouras. All rights reserved.
//

import Foundation
import UIKit

class CardAnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var dismissing = false
    
    init(dismissing: Bool = false) {
        self.dismissing = dismissing
    }
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.8
    }
    
    // This method can only  be a nop if the transition is interactive and not a percentDriven interactive transition.
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        if dismissing {
            hideCard(using: transitionContext)
        } else {
            showCard(using: transitionContext)
        }
    }
    
    private func showCard(using transitionContext: UIViewControllerContextTransitioning) {
        guard let toViewController = transitionContext.viewController(forKey: .to) else
        { return }
        
        let containerView = transitionContext.containerView
        containerView.addSubview(toViewController.view)
        
        containerView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.shadowOffset = CGSize(width: 0, height: -2)
        containerView.layer.shadowOpacity = 0.14
        containerView.layer.shadowRadius = 4.0
        
        let CornerRadius: CGFloat = 8.0
        
        let maskView = UIView(frame: containerView.bounds)
        maskView.frame.size.height += CornerRadius
        maskView.layer.cornerRadius = CornerRadius
        maskView.backgroundColor = .black
        toViewController.view.mask = maskView
        
        toViewController.view.frame.origin.y = containerView.bounds.size.height
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
                toViewController.view.frame.origin.y = 0
            }) { done in
            transitionContext.completeTransition(true)
        }
    }
    
    private func hideCard(using transitionContext: UIViewControllerContextTransitioning) {
        guard let fromViewController = transitionContext.viewController(forKey: .from),
            let toViewController = transitionContext.viewController(forKey: .to) else
        { return }
        
        toViewController.beginAppearanceTransition(true, animated: true)
        
        let duration = transitionDuration(using: transitionContext)
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 1.0, initialSpringVelocity: 0.8, options: .curveEaseOut, animations: {
            fromViewController.view.frame.origin.y = toViewController.view.bounds.size.height
        }) { done in
            toViewController.endAppearanceTransition()
            transitionContext.completeTransition(true)
        }


    }
    
}
