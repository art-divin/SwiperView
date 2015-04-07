//
//  SwiperCell.swift
//  SwiperDemo
//
//  Created by Ruslan Alikhamov on 30/01/15.
//  Copyright (c) 2015 Ruslan Alikhamov. All rights reserved.
//

import UIKit

class SwiperCell: UITableViewCell {

	var leftCallback: (Void -> Void)?
	var rightCallback: (Void -> Void)?
	private var swiperView: SwiperView?
	var textLbl: UILabel = UILabel()
	var leftLbl: UILabel = UILabel()
	var rightLbl: UILabel = UILabel()
	override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		swiperView = SwiperView(frame: CGRect(x: 0, y: 0, width: 1, height: 1), leftInset: -95, rightInset: -95)
		self.contentView.addSubview(swiperView!)
		swiperView!.setTranslatesAutoresizingMaskIntoConstraints(false)
		self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[swiper]|", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "swiper" : swiperView! ]))
		self.contentView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[swiper]|", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "swiper" : swiperView! ]))
		self.contentView.bringSubviewToFront(swiperView!)
		
		textLbl.numberOfLines = 0;
		textLbl.lineBreakMode = .ByWordWrapping
		textLbl.setTranslatesAutoresizingMaskIntoConstraints(false)
		
		// adding text label on top of vibrancy visual effect view
		swiperView!.topmostView().addSubview(textLbl)
		textLbl.setTranslatesAutoresizingMaskIntoConstraints(false)
		var constraints: [NSLayoutConstraint] = NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "label" : textLbl ]) as! [NSLayoutConstraint]
		constraints += NSLayoutConstraint.constraintsWithVisualFormat("H:|-[label]", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "label" : textLbl ]) as! [NSLayoutConstraint]
		swiperView!.topmostView().addConstraints(constraints)
		
		// adding labels below blurred view
		leftLbl.backgroundColor = UIColor.blueColor()
		rightLbl.backgroundColor = UIColor.redColor()
		leftLbl.textAlignment = .Center
		rightLbl.textAlignment = .Center
		leftLbl.textColor = UIColor.whiteColor()
		rightLbl.textColor = UIColor.whiteColor()
		
		swiperView!.addSubview(leftLbl);
		swiperView!.addSubview(rightLbl);
		leftLbl.setTranslatesAutoresizingMaskIntoConstraints(false)
		rightLbl.setTranslatesAutoresizingMaskIntoConstraints(false)
		swiperView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[leftLbl(>=100)]", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "leftLbl" : leftLbl ]))
		swiperView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:[rightLbl(>=100)]|", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "rightLbl" : rightLbl ]))
		
		swiperView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "label" : leftLbl ]))
		swiperView!.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[label]|", options: NSLayoutFormatOptions(0), metrics: nil, views: [ "label" : rightLbl ]))
		swiperView?.leftCallback = { [weak self] in
			if let callback = self?.leftCallback {
				callback()
			}
		}
		swiperView?.rightCallback = { [weak self] in
			if let callback = self?.rightCallback {
				callback()
			}
		}
		self.selectionStyle = .None
	}

	required init(coder aDecoder: NSCoder) {
	    fatalError("init(coder:) has not been implemented")
	}

	override func layoutSubviews() {
		super.layoutSubviews()
		swiperView?.frame = self.contentView.bounds
	}
	
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
