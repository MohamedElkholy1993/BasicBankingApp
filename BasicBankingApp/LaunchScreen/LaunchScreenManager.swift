//
//  LaunchScreenManager.swift
//  BasicBankingApp
//
//  Created by User on 07/04/2022.
//

import Foundation
import UIKit

class LaunchScreenManager {

    // MARK: - Properties

    // Using a singleton instance and setting animationDurationBase on init makes this class easier to test
    static let instance = LaunchScreenManager(animationDurationBase: 1.3)

    var view: UIView?
    var parentView: UIView?

    let animationDurationBase: Double


    // MARK: - Lifecycle

    init(animationDurationBase: Double) {
        self.animationDurationBase = animationDurationBase
    }


    // MARK: - Animation

    func animateAfterLaunch(_ parentViewPassedIn: UIView) {
        parentView = parentViewPassedIn
        view = loadView()

        fillParentViewWithView()
        hideRingSegments()
    }
    
    func hideRingSegments() {
        // A large number to ensure that rotated segments don't partially
        // rotate back on-screen
        let distanceToMove = parentView!.frame.size.height * 2

        for number in 1...12 {
            // Ring segments should be tagged 1-12
            let ringSegment: UIView = view!.viewWithTag(number)!

            // Get the degrees we want to move to
            let degrees = 360 - (number * 30) + 15

            // Convert to float
            let angle = CGFloat(degrees)

            // Convert to radians
            let radians = angle * (CGFloat.pi / 180)

            // Calculate the final X value from this angle and the total distance.
            // See https://academo.org/demos/rotation-about-point/ for more.
            let translationX = (cos(radians) * distanceToMove)
            let translationY = (sin(radians) * distanceToMove) * -1

            UIView.animate(
                withDuration: animationDurationBase * 1.75,
                delay: animationDurationBase / 1.5,
                options: .curveLinear,
                animations: {
                      var transform = CGAffineTransform.identity
                      transform = transform.translatedBy(x: translationX, y: translationY)

                      // This rotation accounts for the curve in the segment images.
                      // I just eyeballed it; different curves will require different rotations.
                      transform = transform.rotated(by: -1.95)

                      ringSegment.transform = transform
                  },
                completion: { _ in
                    self.view!.removeFromSuperview()
                }
            )
            DispatchQueue.main.asyncAfter(deadline: .now() + animationDurationBase * 1.25) {
                self.view!.removeFromSuperview()
            }
        }
    }

    func loadView() -> UIView {
        return UINib(nibName: "LaunchScreen", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }

    func fillParentViewWithView() {
        parentView!.addSubview(view!)

        view!.frame = parentView!.bounds
        view!.center = parentView!.center
    }
}
