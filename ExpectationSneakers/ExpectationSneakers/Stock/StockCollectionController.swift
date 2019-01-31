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
    
    var stockSneakers = [SneakerFirebase]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


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
        cell.sneakerImage.image = getImageFromBase64(base64: stockSneaker.image64)//stockSneaker.image
        cell.modelLabel.text = stockSneaker.model
        // Configure the cell
    
        return cell
    }
    
    func getImageFromBase64(base64:String) -> UIImage {
        let data = Data(base64Encoded: base64)
        return UIImage(data: data!)!
    }
    
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
        let detailVC = segue.destination as! ChooseSneakerController
        let cell = sender as! StockViewCell
        let index = self.collectionView.indexPath(for: cell)
        detailVC.sneakerDetailFirebase = stockSneakers[(index?.row)!]
    }


}
