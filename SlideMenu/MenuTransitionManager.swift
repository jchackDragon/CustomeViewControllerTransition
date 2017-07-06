//
//  MenuTransitionManager.swift
//  SlideMenu
//
//  Created by Juan Carlos Lopez on 7/5/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation
import UIKit

@objc protocol MenuTransitionManagerDelegate {
    func dismiss()
}

class MenuTransitionManager: NSObject, UIViewControllerAnimatedTransitioning, UIViewControllerTransitioningDelegate {
    
    var delegate:MenuTransitionManagerDelegate?
    var duration = 0.5
    var isPresenting = true
    
    var snapshot:UIView? {
        didSet {
            if let _delegate = delegate {
                
                let tapGestureRecognizer = UITapGestureRecognizer(target: _delegate, action: #selector(_delegate.dismiss))
                snapshot?.addGestureRecognizer(tapGestureRecognizer)
            }
        }
    }
    
    
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return duration
    }
    
    
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        // Get reference to our fromView, toView and the container view
        let fromView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
        let toView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
        
        // Set up the transform for sliding
        let container = transitionContext.containerView
        let moveDown = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
        //let moveDown = CGAffineTransform(translationX: 0, y: -50)
        
        let moveUp = CGAffineTransform(translationX: 0, y: -50)
        //let moveUp = CGAffineTransform(translationX: 0, y: container.frame.height - 150)
        // Add both views to the container view
        if isPresenting {
            toView.transform = moveUp
            snapshot = fromView.snapshotView(afterScreenUpdates: true)
            container.addSubview(toView)
            container.addSubview(snapshot!)
        }
        
        // Perform the animation
        UIView.animate(withDuration: duration, delay: 0.0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0.8, options: [], animations: {
            
            if self.isPresenting {
                self.snapshot?.transform = moveDown
                toView.transform = CGAffineTransform.identity
            } else {
                self.snapshot?.transform = CGAffineTransform.identity
                fromView.transform = moveUp
            }
        }) { finished in
            
            transitionContext.completeTransition(true)
            if !self.isPresenting {
               self.snapshot?.removeFromSuperview()
            }
        }
    }
        
//        UIView.animate(withDuration: duration, delay: 0.0, options: [], animations: {
//            if self.isPresenting {
//                self.snapshot?.transform = moveDown
//                toView.transform = CGAffineTransform.identity
//            } else {
//                self.snapshot?.transform = CGAffineTransform.identity
//                fromView.transform = moveUp
//            }
//        }) { finished in
//
//            transitionContext.completeTransition(true)
//            if !self.isPresenting {
//                self.snapshot?.removeFromSuperview()
//            }
//        }
//
//    }
//    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        isPresenting = true
//        return self
//    }
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = false
        return self
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        isPresenting = true
        return self
    }
    
//    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
//
//        isPresenting = false
//        return self
//    }
//
    
    
}
