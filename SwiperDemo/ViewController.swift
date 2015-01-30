//
//  ViewController.swift
//  SwiperDemo
//
//  Created by Ruslan Alikhamov on 30/01/15.
//  Copyright (c) 2015 Ruslan Alikhamov. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

	let cellID = "cellID"
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
		self.tableView.registerClass(SwiperCell.self, forCellReuseIdentifier: cellID)
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	// :MARK: UITableViewDataSource
	
	override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}
	
	override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 2
	}
	
	override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		var cell = tableView.dequeueReusableCellWithIdentifier(cellID) as SwiperCell
		cell.leftLbl.text = "Left"
		cell.rightLbl.text = "Right"
		cell.textLbl.text = "Some text on vibrancy effect view"
		cell.leftCallback = {
			println("left callback toggled")
		}
		cell.rightCallback = {
			println("right callback toggled")
		}
		return cell
	}
	
	// :MARK: UITableViewDelegate
	
	override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
		return 44.0
	}
	
}

