//
//  dissmissMenuAnimator.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 24..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class DismissMenuAnimator: NSObject {
    
    
    
}

extension DismissMenuAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.2
    }
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let originalVC = transitionContext.viewController(forKey: .from) else { return }
        guard let targetVC = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        
        //스냅샷 뷰를 가져온다.
        let snapshot = containerView.viewWithTag(MenuHelper.snapshotNumber)
        
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            snapshot?.frame = CGRect(origin: CGPoint.zero, size: UIScreen.main.bounds.size)
        }) { _ in
            let didTransitionCompelte = !transitionContext.transitionWasCancelled
            if didTransitionCompelte {
                containerView.insertSubview(targetVC.view, aboveSubview: originalVC.view)
                snapshot?.removeFromSuperview()
            }
            transitionContext.completeTransition(didTransitionCompelte)
        }
    }
}
