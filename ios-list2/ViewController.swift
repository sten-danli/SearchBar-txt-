//
//  ViewController.swift
//  ios-list2
//
//  Created by Michael Kofler on 17.03.15.
//  Copyright (c) 2015 Michael Kofler. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

  @IBOutlet weak var tableView: UITableView!
  
    var searchController:UISearchController!
    
    var mydata = Country.readFromBundle()
    var filteredData=[Country]()
    var shouldShowSearchResults=false
  
  override func viewDidLoad() {
    super.viewDidLoad()
    tableView.delegate = self
    tableView.dataSource = self
    configureSearchController()
  }
}

extension ViewController:UISearchResultsUpdating,UISearchBarDelegate{
    
    func configureSearchController(){
        searchController=UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater=self
        searchController.dimsBackgroundDuringPresentation=false
        searchController.searchBar.placeholder="Search here"
        searchController.searchBar.delegate=self
        searchController.searchBar.sizeToFit()
        
        tableView.tableHeaderView=searchController.searchBar
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //Todo
        if let searchText=searchController.searchBar.text, searchText != ""{
            filteredData=mydata.filter{ data in
                return data.name.lowercased().contains(searchText.lowercased())
            }
        }else{
            filteredData=mydata
        }
        tableView.reloadData()
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if !shouldShowSearchResults{
            shouldShowSearchResults = true
            tableView.reloadData()
        }
        searchController.searchBar.resignFirstResponder()
    }
    

}

// DataSource-Methoden
extension ViewController: UITableViewDataSource {
  // gibt die Anzahl der Abschnitte der Liste an
  func numberOfSections(in tableView: UITableView) -> Int
  {
    return 1
  }
  
  // gibt die Anzahl der Listenelemente an
  func tableView(_ tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int
  {
    if shouldShowSearchResults{
        return filteredData.count
    }else{
        return mydata.count

    }
  }
  
  // liefert Tabellenzellen zur Darstellung im Steuerelement
  func tableView(_ tableView: UITableView,
    cellForRowAt indexPath: IndexPath)
    -> UITableViewCell
  {
    // Zelle aus einer Prototypzelle lesen
    let cell = tableView.dequeueReusableCell(
      withIdentifier: "cell")!
    let row = indexPath.row
    // Titel und Untertitel einstellen
    if shouldShowSearchResults{
       
        cell.textLabel!.text = filteredData[row].name
        cell.detailTextLabel?.text = filteredData[row].capital
    }else{
        cell.textLabel?.text = mydata[row].name
        cell.detailTextLabel?.text = mydata[row].capital

    }
    
    // Bilder aus Xcassets-Datei
    let name = mydata[row].name.replacingOccurrences(
      of: "ü", with: "ue")
    cell.imageView!.image = UIImage(named: name)
    
    return cell
  }
}

// TableView-Delegates
extension ViewController: UITableViewDelegate {
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailView"{
           let dvc = segue.destination as! DetailViewController
            if let indexPath = tableView.indexPathForSelectedRow?.row{
                let okData:Country
                if shouldShowSearchResults{
                    okData=filteredData[indexPath]
                }else{
                    okData=mydata[indexPath]
                }
                    dvc.detailViewData=okData
                
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        performSegue(withIdentifier: "toDetailView", sender: nil)
            
        }
    
}
