//
//  CartTableViewController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/11/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit
import Firebase

class CartTableViewController: UITableViewController {
    
    var refCart: DatabaseReference!
    var cartFirebase = [CartFirebase]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(idTransaction.id != ""){
            getDataSneakerFirebase()
        }
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        //navigationController?.tabBarItem.image = UIImage(named: "Cart40")?.withRenderingMode(.alwaysOriginal)
        
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return cartFirebase.count
    }
    
    func getDataSneakerFirebase(){
        refCart = Database.database().reference(withPath: "cart-db").child(idTransaction.id)
        cartFirebase.removeAll()
        refCart.observe(.value, with: { snapshot in
            //  print(snapshot.value as Any)
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let cartFirebaseItem = CartFirebase(snapshot: snapshot) {
                    self.cartFirebase.append(cartFirebaseItem)
                }
            }
            self.tableView.reloadData()
        })
        
        
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cartItem", for: indexPath)

        // Configure the cell...
        
        cell.textLabel?.text = cartFirebase[indexPath.row].model

        return cell
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func viewWillAppear(_ animated: Bool) {
        self.viewDidLoad()
    }
    
    

}
