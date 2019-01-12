//
//  StockCollectionController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/10/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

//private let reuseIdentifier = "cellStockItem"



class StockCollectionController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var stockSneakers = [Sneaker]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes
        //self.collectionView!.register(UICollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)

        // Do any additional setup after loading the view.
        //getAllStockSneakers()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return stockSneakers.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellStockItem", for: indexPath) as! StockViewCell
        
        let stockSneaker = stockSneakers[indexPath.row]
        cell.sneakerImage.image = stockSneaker.image
        cell.modelLabel.text = stockSneaker.name
        // Configure the cell
    
        return cell
    }

    // MARK: UICollectionViewDelegate

    /*
    // Uncomment this method to specify if the specified item should be highlighted during tracking
    override func collectionView(_ collectionView: UICollectionView, shouldHighlightItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment this method to specify if the specified item should be selected
    override func collectionView(_ collectionView: UICollectionView, shouldSelectItemAt indexPath: IndexPath) -> Bool {
        return true
    }
    */

    /*
    // Uncomment these methods to specify if an action menu should be displayed for the specified item, and react to actions performed on the item
    override func collectionView(_ collectionView: UICollectionView, shouldShowMenuForItemAt indexPath: IndexPath) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, canPerformAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return false
    }

    override func collectionView(_ collectionView: UICollectionView, performAction action: Selector, forItemAt indexPath: IndexPath, withSender sender: Any?) {
    
    }
    */
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 316, height: 135)
        
        
            
            let screenSize = UIScreen.main.bounds
            let widthValue = (screenSize.width / 5.0) * 1.5
            
            return CGSize(width: widthValue, height: widthValue)  
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        //        let nav = segue.destination as! UINavigationController
        //        //let svc = nav.topViewController as! DetailTopSellController
        //
        //
        //        let senakerSeleccionadoRecibido = sender as! TopCellViewCell
        //
        //        let objetoPantalla2 = nav.topViewController as! DetailTopSellController
        //        let index = topSellCView?.indexPath(for: senakerSeleccionadoRecibido)
        //        objetoPantalla2.sneakerDetail = topSellSneaker[(index?.row)!]
        
        
        let detailVC = segue.destination as! ChooseSneakerController
        let cell = sender as! StockViewCell
        let index = self.collectionView.indexPath(for: cell)
        detailVC.sneakerDetail = stockSneakers[(index?.row)!]
    }


}
