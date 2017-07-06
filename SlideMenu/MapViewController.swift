//
//  MapViewController.swift
//  SlideMenu
//
//  Created by Juan Carlos Lopez on 7/5/17.
//  Copyright © 2017 AppCoda. All rights reserved.
//

import Foundation

//
//  NewsTableViewController.swift
//  SlideMenu
//
//  Created by Simon Ng on 7/2/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit

class MapViewController: UIViewController, MenuTransitionManagerDelegate{
    
    var menuTransitionManager = MenuTransitionManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Home"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToHome(segue: UIStoryboardSegue) {
        let sourceController = segue.source as! MenuTableViewController
        self.title = sourceController.currentItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let menuTableViewController = segue.destination as! MenuTableViewController
        menuTableViewController.currentItem = self.title!
        menuTableViewController.transitioningDelegate = self.menuTransitionManager
        self.menuTransitionManager.delegate = self
    }
    
    func dismiss() {
        dismiss(animated: true, completion: nil)
    }
}
