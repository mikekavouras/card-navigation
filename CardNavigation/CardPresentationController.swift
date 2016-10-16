//
//  CardPresentationController.swift
//  CardNavigation
//
//  Created by Mike Kavouras on 10/16/16.
//  Copyright © 2016 Mike Kavouras. All rights reserved.
//

import UIKit

class CardPresentationController: UIPresentationController {
    
    static let FromTop: CGFloat = 64.0
    
    var dimmingView = UIView()
    
    override func size(forChildContentContainer container: UIContentContainer, withParentContainerSize parentSize: CGSize) -> CGSize {
        return CGSize(width: parentSize.width, height: parentSize.height - CardPresentationController.FromTop)
    }
    
    override var frameOfPresentedViewInContainerView: CGRect {
        var presentedViewFrame = CGRect.zero
        let containerBounds = containerView!.bounds
        
        let contentContainer = presentedViewController
        
        presentedViewFrame.size = size(forChildContentContainer: contentContainer, withParentContainerSize: containerBounds.size)
        presentedViewFrame.origin.y = CardPresentationController.FromTop
        
        return presentedViewFrame
    }
    
    override func containerViewWillLayoutSubviews() {
        presentedView?.frame = frameOfPresentedViewInContainerView
    }

    override func presentationTransitionWillBegin() {
        
        setupDimmingView()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 1.0
        }, completion: nil)
    }
    
    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { context in
            self.dimmingView.alpha = 0.0
            }, completion: nil)
    }
    
    private func setupDimmingView() {
        guard let containerView = containerView else { return }
        
        dimmingView.frame = containerView.bounds
        dimmingView.alpha = 0.0
        dimmingView.backgroundColor = UIColor.black.withAlphaComponent(0.4)
        containerView.insertSubview(dimmingView, at: 0)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(dimmingViewTapped))
        dimmingView.addGestureRecognizer(tap)
    }

    @objc private func dimmingViewTapped() {
        presentingViewController.dismiss(animated: true, completion: nil)
    }
}
