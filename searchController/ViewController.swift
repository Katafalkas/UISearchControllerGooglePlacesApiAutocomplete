//
//  ViewController.swift
//  searchController
//
//  Created by audrius kucinskas on 12/10/14.
//  Copyright (c) 2014 trueisfalse. All rights reserved.
//

import UIKit
import Foundation
import Alamofire

class ViewController: UIViewController {

    let googleApiKey:String = ""
    // Number of letters you need in searchbar to start sending requests to google
    let kMinLettersForRequest = 4
    
    func returnGooglePredictionUrlString(input:String) -> String {
        var predictionUrlString = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(input)&types=geocode&language=en&key=\(self.googleApiKey)"
        return predictionUrlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    }
    
    func retturnGoogleDetailUrlString(placeId:String) -> String {
        var detailsUrlString = "https://maps.googleapis.com/maps/api/place/details/json?placeid=\(placeId)&key=\(self.googleApiKey)"
        return detailsUrlString.stringByAddingPercentEscapesUsingEncoding(NSUTF8StringEncoding)!
    }
    
    var countryTable: UITableView!
    var countrySearchController = UISearchController(searchResultsController: nil)
    var currentPredictions: [[String]] = [[]]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var headerView = UIView(frame: CGRectMake(0.0, 0.0, self.view.bounds.width, 44.0))
        var footerView = UIView(frame: CGRectMake(0.0, 0.0, self.view.bounds.width, 44.0))
        var footerImageView = UIImageView(image: UIImage(named: "powered-by-google"))
        footerImageView.center = footerView.center
        footerView.addSubview(footerImageView)
        
        self.countryTable = UITableView(frame: CGRectMake(0.0, 20.0, self.view.bounds.width, self.view.bounds.height), style: UITableViewStyle.Plain)
        self.countryTable.registerClass(CountryTableViewCell.self, forCellReuseIdentifier: "myReusableCell")
        self.view.addSubview(self.countryTable)
        
        self.countrySearchController.searchResultsUpdater = self
        self.countrySearchController.hidesNavigationBarDuringPresentation = false
        self.countrySearchController.dimsBackgroundDuringPresentation = false
        self.countrySearchController.searchBar.frame = CGRectMake(0.0, 0.0, CGRectGetWidth(self.countryTable.frame), 44.0)
        self.countrySearchController.searchBar.delegate = self
        self.countrySearchController.searchBar.showsCancelButton = false
        self.countrySearchController.searchBar.placeholder = ""
        headerView.addSubview(self.countrySearchController.searchBar)
        self.countryTable.tableHeaderView = headerView
        self.countryTable.tableFooterView = footerView
        
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
        if self.currentPredictions.count == 1 {
            return 0
        } else {
            return self.currentPredictions.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: CountryTableViewCell = tableView.dequeueReusableCellWithIdentifier("myReusableCell", forIndexPath: indexPath) as CountryTableViewCell
        cell.countryLabel.text = "\(self.currentPredictions[indexPath.row][0])"
        
        return cell
    }
    
}

extension ViewController: UISearchResultsUpdating {
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        
        var numberOfCharacters = countElements(searchController.searchBar.text)
        
        if numberOfCharacters >= self.kMinLettersForRequest {
            googleApi(searchController.searchBar.text)
        } else if numberOfCharacters < kMinLettersForRequest {
            self.currentPredictions.removeAll(keepCapacity: false)
            self.countryTable.reloadData()
        }
    }
    
    func googleApi(inputFromSearchBar:String) {
        
        var predictionUrlString = self.returnGooglePredictionUrlString(inputFromSearchBar)
        
        var jdata:AnyObject = []
        var predictions:Array<AnyObject> = []
        
        let res = Alamofire.request(.GET, predictionUrlString)
            .responseJSON { (_, _, JSON, _) in
                jdata = JSON!
                predictions = jdata["predictions"] as Array
                self.currentPredictions.removeAll(keepCapacity: true)
                for predIndex in predictions {
                    var predictionPlaceIdArray = [predIndex["description"] as String, predIndex["place_id"] as String]
                    self.currentPredictions.append(predictionPlaceIdArray)
                    
                self.countryTable.reloadData()
                }
        }
    }
}

extension ViewController: UISearchBarDelegate {
    func searchBarTextDidBeginEditing(searchBar: UISearchBar){
        self.countrySearchController.searchBar.showsCancelButton = false
    }
    
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        self.countrySearchController.searchBar.showsCancelButton = false
        return true
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar){
        println("Search Button Clicked")
        self.countrySearchController.searchBar.showsCancelButton = false
    }
    
    func searchBar(searchBar: UISearchBar, textDidChange searchText: String) {
        self.countrySearchController.searchBar.showsCancelButton = false
    }
}
