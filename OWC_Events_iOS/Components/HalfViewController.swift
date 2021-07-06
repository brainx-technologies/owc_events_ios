//
//  HalfViewController.swift
//  OWC_Events_iOS
//
//  Created by BrainX Technologies on 6/9/21.
//

import UIKit

class HalfViewController: UIPresentationController {
    // MARK: - Instance Variables

    let blurEffectView: UIVisualEffectView!
    var tapGestureRecognizer = UITapGestureRecognizer()

    // MARK: - Override Methods

    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        blurEffectView = UIVisualEffectView(effect: blurEffect)
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

    override var frameOfPresentedViewInContainerView: CGRect {
        return CGRect(origin: CGPoint(x: 0, y: self.containerView!.frame.height - 320), size: CGSize(width: self.containerView!.frame.width, height: 320))
    }

    override func dismissalTransitionWillBegin() {
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0
            self.containerView?.backgroundColor = UIColor.black.withAlphaComponent(0)
        }, completion: { _ in
            self.blurEffectView.removeFromSuperview()
        })
    }

    override func presentationTransitionWillBegin() {
        blurEffectView.alpha = 0
        containerView?.isUserInteractionEnabled = true
        containerView?.addGestureRecognizer(tapGestureRecognizer)
        containerView?.backgroundColor = UIColor.black.withAlphaComponent(0)
        containerView?.addSubview(blurEffectView)
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: { _ in
            self.blurEffectView.alpha = 0
            self.containerView?.backgroundColor = .black.withAlphaComponent(0.5)
        }, completion: { _ in

        })
    }

    override func containerViewWillLayoutSubviews() {
        super.containerViewWillLayoutSubviews()
        presentedView!.layer.masksToBounds = true
        presentedView!.layer.cornerRadius = 10
    }

    override func containerViewDidLayoutSubviews() {
        super.containerViewDidLayoutSubviews()
        presentedView?.frame = frameOfPresentedViewInContainerView
        blurEffectView.frame = containerView!.bounds
    }

    // MARK: - Action Methods

    @objc
    func dismiss() {
        presentedViewController.dismiss(animated: true, completion: nil)
    }
}
