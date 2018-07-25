//
//  menuHelper.swift
//  DailyNote
//
//  Created by 전솔 on 2018. 7. 24..
//  Copyright © 2018년 전솔. All rights reserved.
//

import UIKit

enum Direction {
    case up
    case down
    case left
    case right
}
class MenuHelper: NSObject {
    static let menuWidth: CGFloat = 0.8 // 얼마만큼 슬라이드 될것인가
    static let percentThreshold: CGFloat = 0.3 // 제스터가 얼마만큼 되었을 때 슬라이드 시킬 것인가
    static let snapshotNumber = 12345 // 스냅샷 태그
    
    static func calculateProgress(translationInView: CGPoint, viewBounds: CGRect, direction: Direction) -> CGFloat {
        let pointOnAxis: CGFloat
        let axisLength: CGFloat
        
        // direction 의 매개변수에 따라 달라짐
        switch direction {
        case .down, .up:
            pointOnAxis = translationInView.y
            axisLength = viewBounds.height
        case .left, .right:
            pointOnAxis = translationInView.x
            axisLength = viewBounds.width
        }
        
        let movementOnAxis = pointOnAxis / axisLength // 축에 따라 얼만큼 이동했는가
        let positiveMovementOnAxis: Float
        let positiveMovementOnAxisPercent: Float
        
        switch direction {
        case .right, .down:
            positiveMovementOnAxis = fmaxf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fminf(positiveMovementOnAxis, 1.0)
            return CGFloat(positiveMovementOnAxisPercent)
        case .left, .up:
            positiveMovementOnAxis = fminf(Float(movementOnAxis), 0.0)
            positiveMovementOnAxisPercent = fmaxf(positiveMovementOnAxis, -1.0)
            return CGFloat(-positiveMovementOnAxisPercent)
        }
    }
    static func mapGestureStateToInteractor(gestureState: UIGestureRecognizerState, progress: CGFloat, interactor: Interactor?, triggerSegue: () -> Void) {
        
        guard let interactor = interactor else {return}
        switch gestureState {
        case .began:
            interactor.hasStarted = true
            triggerSegue()
        case .changed:
            interactor.shouldFinish = progress > percentThreshold
            interactor.update(progress)
        case .cancelled:
            interactor.hasStarted = false
            interactor.cancel()
        case .ended:
            interactor.hasStarted = false
            interactor.shouldFinish ? interactor.finish() : interactor.cancel()
        default:
            break
        }
    }
}
