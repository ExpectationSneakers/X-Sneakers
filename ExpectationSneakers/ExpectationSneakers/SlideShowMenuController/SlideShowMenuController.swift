//
//  SlideShowMenuController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/3/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit

class SlideShowMenuController:UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var slidePhotoCView: UICollectionView!
    
    let photosArray:[String] = ["Jordan1","Jordan3","Jordan4","Versace","Puma"]
    var scrollingTimer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        slidePhotoCView.delegate = self
        slidePhotoCView.dataSource = self
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slidePhoto", for: indexPath) as! PhotoSlideViewCell
        
        cell.photoCell.image = UIImage(named: photosArray[indexPath.row])
        
        var indexRow = indexPath.row
        
        let numberImage : Int = self.photosArray.count - 1
        
        if(indexRow < numberImage){
            indexRow = (indexRow + 1)
        }else{
            indexRow = 0
        }
        
        scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector( SlideShowMenuController.startTimer(theTimer:)), userInfo: indexRow, repeats: true)
        
        return cell
    }
    
    
    @objc func startTimer(theTimer: Timer){
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.slidePhotoCView.scrollToItem(at: IndexPath(row: theTimer.userInfo as! Int, section: 0), at: .centeredHorizontally, animated: false)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photosArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 316, height: 135)
        
        let screenSize = UIScreen.main.bounds
        let widthValue = (screenSize.width / 1.0) * 0.5
        
        return CGSize(width: widthValue, height: widthValue)
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    
    
}
