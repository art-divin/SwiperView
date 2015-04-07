//
//  SwiperView.swift
//  Mester
//
//  Created by Ruslan Alikhamov on 29/01/15.
//  Copyright (c) 2015 Ruslan Alikhamov. All rights reserved.
//

import UIKit

class SwiperView: UIView, UICollisionBehaviorDelegate {
	
	private var contentView: UIVisualEffectView?
	private var animator: UIDynamicAnimator?
	private var snapBehaviour: UISnapBehavior?
	private var collisionBehaviour: UICollisionBehavior?
	private var attachmentBehaviour: UIAttachmentBehavior?
	private var collisionInset: UIEdgeInsets?
	private var panGesture: UIPanGestureRecognizer?
	
	var rightCallback: (Void -> Void)?
	var leftCallback: (Void -> Void)?
	
	func topmostView() -> UIView! {
		return contentView?.contentView
	}
	
	init(frame: CGRect, leftInset: CGFloat, rightInset: CGFloat) {
		super.init(frame: frame)
		let blurEffect = UIBlurEffect(style: .ExtraLight)
		contentView = UIVisualEffectView(effect: blurEffect)
		collisionInset = UIEdgeInsets(top: 0, left: leftInset, bottom: 0, right: rightInset)
	}
	
	override var frame: CGRect {
		didSet {
			contentView?.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height)
			if let contentView = contentView {
				animator?.removeAllBehaviors()
				let vibrancyEffect = UIVibrancyEffect(forBlurEffect: contentView.effect as! UIBlurEffect)
				let vibrantView = UIVisualEffectView(effect: vibrancyEffect)
				vibrantView.frame = contentView.bounds
				vibrantView.autoresizingMask = .FlexibleWidth | .FlexibleHeight
				contentView.contentView.addSubview(vibrantView)
				self.addSubview(contentView)
				animator = UIDynamicAnimator(referenceView: self)
				let dynamicBehaviour = UIDynamicItemBehavior(items: [contentView])
				dynamicBehaviour.allowsRotation = false
				animator?.addBehavior(dynamicBehaviour)
				panGesture = UIPanGestureRecognizer(target: self, action: "contentViewDragged:")
				contentView.addGestureRecognizer(panGesture!)
				snapBehaviour = UISnapBehavior(item: contentView, snapToPoint: CGPoint(x: CGRectGetMidX(frame), y: CGRectGetMidY(frame)))
				animator?.addBehavior(snapBehaviour)
				collisionBehaviour = UICollisionBehavior(items: [contentView])
				collisionBehaviour?.collisionDelegate = self
				if let inset = self.collisionInset {
					collisionBehaviour?.setTranslatesReferenceBoundsIntoBoundaryWithInsets(inset)
				}
				collisionBehaviour?.collisionMode = .Boundaries
				animator?.addBehavior(collisionBehaviour)
				animator?.updateItemUsingCurrentState(contentView)
			}
		}
	}
	
	override func addSubview(view: UIView) {
		super.addSubview(view)
		self.bringSubviewToFront(contentView!)
	}
	
	func contentViewDragged(pan: UIPanGestureRecognizer) {
		var center = pan.locationInView(self)
		switch pan.state {
		case .Began:
			attachmentBehaviour = UIAttachmentBehavior(item: contentView!, offsetFromCenter: UIOffsetZero, attachedToAnchor: center)
			animator?.addBehavior(attachmentBehaviour)
			animator?.removeBehavior(snapBehaviour)
		case .Changed:
			center.y = CGRectGetMidY(self.bounds)
			attachmentBehaviour?.anchorPoint = center
		case .Ended, .Cancelled:
			animator?.removeBehavior(attachmentBehaviour)
			animator?.addBehavior(snapBehaviour)
			attachmentBehaviour = nil
		default: break
		}
	}
	
	required init(coder aDecoder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
	
	// :MARK: UICollisionBehaviorDelegate
	
	func collisionBehavior(behavior: UICollisionBehavior, beganContactForItem item: UIDynamicItem, withBoundaryIdentifier identifier: NSCopying, atPoint p: CGPoint) {
		if let gesture = panGesture {
			if gesture.state != .Possible {
				if p.x > 0 {
					if let callback = leftCallback {
						callback()
					}
				} else {
					if let callback = rightCallback {
						callback()
					}
				}
				// forcing gesture to cancel
				panGesture?.enabled = false
				panGesture?.enabled = true
			}
		}
	}
	
}
