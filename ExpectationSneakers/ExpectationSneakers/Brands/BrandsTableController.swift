//
//  BrandsTableController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/9/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

class BrandsTableController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let arrayBrands : [String] = ["Air Jordan","Nike","Adidas","Reebok","Puma","Vans","Supra","New Balance","Converse","BAPE","Under Armour"]
    
    var filteredBrand = [String]()
    
    
    var stockSneakers = [Sneaker]()
    
   
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getAllStockSneakers()
        
        filteredBrand = arrayBrands
        self.tableView.tableHeaderView = searchController.searchBar
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.delegate = self
        searchController.searchBar.barTintColor = UIColor.lightGray

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.filteredBrand.count
    }

   
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "brandCell", for: indexPath)
        //cell.textLabel?.text = arrayBrands[indexPath.row]
        
        
        cell.textLabel?.text = self.filteredBrand[indexPath.row]
       
        // Configure the cell...
        
        return cell
    }
    
    //   _ el signo guion bajo indica que se va a omitir el argumetn label
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idBrandSelected = indexPath.row
        self.performSegue(withIdentifier: "segueStock", sender: idBrandSelected)
    }
    
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    
    
    
    func applySearch(searchText: String) {
        
        
        if searchController.searchBar.text! != "" {
            filteredBrand = arrayBrands.filter { brand in
                return brand.lowercased().contains(searchText.lowercased())
            }
        }
        
        
        self.tableView.reloadData()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        //applySearch(searchText: searchController.searchBar.text!)
        
        applySearch(searchText: searchController.searchBar.text!)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        applySearch(searchText: searchController.searchBar.text!)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewDidLoad()
        
        self.searchController.searchBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
        self.tableView.reloadData()
        //super.viewDidLoad()
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.searchController.searchBar.isHidden = true
        //self.tabBarController?.tabBar.isHidden = true
        
        filteredBrand = arrayBrands

        //self.tabBarController?.tabBar.isHidden = true
        
    }
    
    
    func getAllStockSneakers(){
        
        SneakerService.getSneakers{[weak self] (stockSneakers) in
            self?.stockSneakers = stockSneakers
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let idBrand = sender as! Int
        let stockVC = segue.destination as! StockCollectionController
        
        let selectedBrand:String = arrayBrands[idBrand]
        //let index = UITableViewCell?.indexPath(for: row)
        let filteredStock:[Sneaker] = stockSneakers.filter { sneaker in
            return sneaker.brand.lowercased().contains(selectedBrand.lowercased())
        }
        
        stockVC.stockSneakers = filteredStock
    }
    
    


}
