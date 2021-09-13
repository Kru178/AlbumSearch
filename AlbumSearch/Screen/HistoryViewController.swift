//
//  HistoryViewController.swift
//  AlbumSearch
//
//  Created by Sergei Krupenikov on 10.09.2021.
//

import UIKit

class HistoryViewController: UITableViewController {
    
    var searchHistoryArray = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Search History"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        checkHistory()
    }
    
    func checkHistory() {
        if let savedSearch = UserDefaults.standard.object(forKey: Constants.defaultsKey) as? [String] {
            searchHistoryArray  = savedSearch
        } else {
            searchHistoryArray = [""]
        }
        tableView.reloadData()
    }
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchHistoryArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CellId.historyCell, for: indexPath)
        cell.textLabel?.text = searchHistoryArray[indexPath.row]
        return cell
    }
    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        AlbumsViewController.searchData = searchHistoryArray[indexPath.row]
        let tab = tabBarController?.viewControllers?[0] as! UINavigationController
        tab.popToRootViewController(animated: true)
        tabBarController?.selectedIndex = 0
    }
    
    // MARK: - Clear button delegate
    
    @IBAction func clearButtonPressed(_ sender: UIBarButtonItem) {
        searchHistoryArray.removeAll()
        UserDefaults.standard.setValue(searchHistoryArray, forKey: Constants.defaultsKey)
        tableView.reloadData()
    }
    
}
