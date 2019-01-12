//
//  DetailTopSellController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/4/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

class ChooseSneakerController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var detailPhoto: UIImageView!
    
   
    
    @IBOutlet weak var modelLabel: UILabel!
    
    @IBOutlet weak var genreLabel: UILabel!
    
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    @IBOutlet weak var sizeInfoLabel: UILabel!
    
    @IBOutlet weak var priceLabel: UILabel!
    var sneakerDetail: Sneaker?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //self.tabBarController?.tabBar.isHidden = true
        
        
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        
        detailPhoto.image = sneakerDetail?.image
        modelLabel.text = sneakerDetail?.name
        genreLabel.text = sneakerDetail?.genre
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        guard let sneakerDetail = sneakerDetail else {return 0}
        return sneakerDetail.sizes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cellSize", for: indexPath) as! SizeViewCell
        cell.sizeCellLabel.text = sneakerDetail?.sizes[indexPath.row].size
        cell.propiertiesSizeCell()
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        // Pause the view's session
        //self.navigationController?.setNavigationBarHidden(false, animated: false)
        //self.tabBarController?.tabBar.isHidden = false
        
    }
    
    
}
