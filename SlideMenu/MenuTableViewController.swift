//
//  MenuTableViewController.swift
//  SlideMenu
//
//  Created by Simon Ng on 9/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class MenuTableViewController: UITableViewController {
    var menuItems = ["Home", "News", "Tech", "Finance", "Reviews"]
    var currentItem = "Home"
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! MenuTableViewCell
        
        // Configure the cell...
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = (menuItems[indexPath.row] == currentItem) ? UIColor.white : UIColor.gray
        
        return cell
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        return menuItems.count
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let menuTableViewController = segue.source as! MenuTableViewController
        if let selectedRow = menuTableViewController.tableView.indexPathForSelectedRow?.row {
            currentItem = menuItems[selectedRow]
        }
    }
    
}
