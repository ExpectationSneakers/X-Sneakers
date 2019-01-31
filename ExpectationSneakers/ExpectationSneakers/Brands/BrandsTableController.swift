//
//  BrandsTableController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/9/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit
import Firebase

class BrandsTableController: UITableViewController, UISearchBarDelegate, UISearchResultsUpdating {
    
    let arrayBrands : [String] = ["Air Jordan","Nike","Adidas","Reebok","Puma","Vans","Supra","New Balance","Converse","BAPE","Under Armour"]
    
    @IBOutlet weak var loadIndicatorData: UIActivityIndicatorView!
    var filteredBrand = [String]()
    
    var stockSneakers = [Sneaker]()
    
    var ref: DatabaseReference!
    var stockSneakerFirebase = [SneakerFirebase]()
    
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        loadIndicatorData.startAnimating()
        loadIndicatorData.centerXAnchor.constraint(equalTo: super.view.centerXAnchor).isActive = true
        loadIndicatorData.centerYAnchor.constraint(equalTo: super.view.centerYAnchor).isActive = true
        //getAllStockSneakers()
        getDataSneakerFirebase()
        
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
        return cell
    }
    
    //   _ el signo guion bajo indica que se va a omitir el argumetn label
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let idBrandSelected = indexPath.row
        self.performSegue(withIdentifier: "segueStock", sender: idBrandSelected)
    }
    
 
  
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
        //viewDidLoad()
        
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
    
    func getDataSneakerFirebase(){
        ref = Database.database().reference(withPath: "sneaker-db")
        
        ref.observe(.value, with: { snapshot in
            //  print(snapshot.value as Any)
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let sneakerFirebaseItem = SneakerFirebase(snapshot: snapshot) {
                    self.stockSneakerFirebase.append(sneakerFirebaseItem)
                }
            }
            self.loadIndicatorData.stopAnimating()
            self.loadIndicatorData.isHidden = true
            self.filteredBrand = self.arrayBrands
            self.tableView.tableHeaderView = self.searchController.searchBar
            self.searchController.searchResultsUpdater = self
            self.searchController.dimsBackgroundDuringPresentation = false
            self.searchController.searchBar.delegate = self
            self.searchController.searchBar.barTintColor = UIColor.lightGray
            self.tableView.reloadData()
            print(self.stockSneakerFirebase.count)
        })
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let idBrand = sender as! Int
        let stockVC = segue.destination as! StockCollectionController
        
        let selectedBrand:String = arrayBrands[idBrand]
        //let index = UITableViewCell?.indexPath(for: row)
        let filteredStock:[SneakerFirebase] = stockSneakerFirebase.filter { sneaker in
            return sneaker.brand.lowercased().contains(selectedBrand.lowercased())
        }
        
        stockVC.stockSneakers = filteredStock
    }
    
    


}
