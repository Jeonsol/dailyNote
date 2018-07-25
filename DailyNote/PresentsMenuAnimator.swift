//
//  PresentsMenuAnimator.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 24..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

class PresentsMenuAnimator: NSObject {
    
}

extension PresentsMenuAnimator: UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.6
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        guard let originalVC = transitionContext.viewController(forKey: .from) else { return }
        guard let targetVC = transitionContext.viewController(forKey: .to) else { return }
        let containerView = transitionContext.containerView
        
        // 타겟 뷰를 원본 뷰 밑에 삽인한다.
        containerView.insertSubview(targetVC.view, belowSubview: originalVC.view)
        
        // 스냅샷 뷰
        let snapShot = originalVC.view.snapshotView(afterScreenUpdates: false)
        snapShot?.tag = MenuHelper.snapshotNumber
        snapShot?.isUserInteractionEnabled = false
        snapShot?.layer.shadowOpacity = 0.7
        
        // 스냅샷을 원본 뷰 위로 설정
        containerView.insertSubview(snapShot!, aboveSubview: targetVC.view)
        
        // 스냅샷을 찍고 원뷰는 숨김
        originalVC.view.isHidden = true
        
        // 슬라이드 이동
        UIView.animate(withDuration: transitionDuration(using: transitionContext), animations: {
            snapShot?.center.x += UIScreen.main.bounds.width * MenuHelper.menuWidth
        }) { _ in
            originalVC.view.isHidden = false
            transitionContext.completeTransition(!transitionContext.transitionWasCancelled) // 끝났다고 알려주는 것
        }
    }
}
