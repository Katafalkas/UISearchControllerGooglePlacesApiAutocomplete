//
//  ViewController.swift
//  searchController
//
//  Created by audrius kucinskas on 12/10/14.
//  Copyright (c) 2014 trueisfalse. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    var countryTable: UITableView!
    var countryArray = ["Australia", "Singapore", "Malaysia", "United States", "Germany", "United Kingdom", "Kenya"]
    var searchArray = [String]()
    var countrySearchController = UISearchController(searchResultsController: nil)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var headerView = UIView(frame: CGRectMake(0.0, 0.0, self.view.bounds.width, 44.0))
        
        self.countryTable = UITableView(frame: CGRectMake(0.0, 20.0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Plain)
        self.countryTable.backgroundColor = UIColor.orangeColor()
        self.countryTable.registerClass(CountryTableViewCell.self, forCellReuseIdentifier: "myReusableCell")
        self.view.addSubview(self.countryTable)
        
        self.countrySearchController.searchResultsUpdater = self
        self.countrySearchController.hidesNavigationBarDuringPresentation = false
        self.countrySearchController.dimsBackgroundDuringPresentation = false
        self.countrySearchController.searchBar.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.countryTable.frame), 44.0)
        headerView.addSubview(self.countrySearchController.searchBar)
        self.countryTable.tableHeaderView = headerView
        
        self.countryTable.delegate = self
        self.countryTable.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println(indexPath.section, indexPath.row)
    }
}

// Data Source
extension ViewController: UITableViewDataSource {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.countryArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CountryTableViewCell = tableView.dequeueReusableCellWithIdentifier("myReusableCell", forIndexPath: indexPath) as CountryTableViewCell
        cell.countryLabel.text = "\(self.countryArray[indexPath.row])"
        
        return cell
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        let kMinLettersForRequest = 4
        var numberOfCharacters = countElements(searchController.searchBar.text)
        
        if numberOfCharacters >= kMinLettersForRequest {
        
        }
        
        println("Change in search results: \(searchController.searchBar.text)")
        
        println("Table Height: \(numberOfCharacters)")
        
//        self.countryTable.reloadData()
    }
    
    func googleApi() {
    
    }
}











