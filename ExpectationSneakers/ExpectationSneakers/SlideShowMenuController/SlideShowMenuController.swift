//
//  SlideShowMenuController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/3/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit
import Firebase

class SlideShowMenuController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var slidePhotoCView: UICollectionView!
    
    @IBOutlet weak var topSellCView: UICollectionView!
    
    let photosArray:[String] = ["Jordan1","Jordan3","Jordan4","Versace","Puma"]
    
    var topSellSneaker = [Sneaker]()
    
    var scrollingTimer = Timer()
    
    var ref: DatabaseReference!
    
    var topSellSneakerFirebase = [SneakerFirebase]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        slidePhotoCView.delegate = self
        slidePhotoCView.dataSource = self
        
        topSellCView.delegate = self
        topSellCView.dataSource = self
        
        //self.view.backgroundColor = UIColor(patternImage: UIImage(named: "BG.jpeg")!)
        //self.view.backgroundColor = UIColor.gray
        getAllTopSellSneakers()
        
        ref = Database.database().reference(withPath: "sneaker-db")
        
        ref.observe(.value, with: { snapshot in
            //print(snapshot.value as Any)
             var newItems: [SneakerFirebase] = []
            
            for child in snapshot.children {
                // 4
                if let snapshot = child as? DataSnapshot,
                    let sneakerFirebaseItem = SneakerFirebase(snapshot: snapshot) {
                    newItems.append(sneakerFirebaseItem)
                }
            }
            
            self.topSellSneakerFirebase = newItems
            self.topSellCView.reloadData()
            print("Cargado")
        })
        
        
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView ==  self.slidePhotoCView{
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "slidePhoto", for: indexPath) as! PhotoSlideViewCell
            
            cell.photoCell.image = UIImage(named: photosArray[indexPath.row])
            cell.contentView.layer.cornerRadius = 10.0
            cell.contentView.layer.masksToBounds = true
            //        var indexRow = indexPath.row
            //
            //        let numberImage : Int = self.photosArray.count - 1
            //
            //        if(indexRow < numberImage){
            //            indexRow = (indexRow + 1)
            //        }else{
            //            indexRow = 0
            //        }
            //
            //        scrollingTimer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector( SlideShowMenuController.startTimer(theTimer:)), userInfo: indexRow, repeats: true)
            
            return cell
            
        }else {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellTopSell", for: indexPath) as! TopCellViewCell
            let sneaker = topSellSneaker[indexPath.row]
            let sneakerFirebase = topSellSneakerFirebase[indexPath.row]
            cell.topCellPhoto.image = getImageFromBase64(base64: sneakerFirebase.image64)
            
//            cell.contentView.layer.cornerRadius = 10.0
//            cell.contentView.layer.masksToBounds = true
//
            cell.changeCorner(value: 20.0)
            
            return cell
            
        }
        
        
    }
    
    
    @objc func startTimer(theTimer: Timer){
        UIView.animate(withDuration: 1.0, delay: 0, options: .curveEaseOut, animations: {
            self.slidePhotoCView.scrollToItem(at: IndexPath(row: theTimer.userInfo as! Int, section: 0), at: .centeredHorizontally, animated: false)
        }, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.slidePhotoCView{
            return photosArray.count
        }else{
            return topSellSneakerFirebase.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //return CGSize(width: 316, height: 135)
        
        if collectionView == self.slidePhotoCView{
            
            let screenSize = UIScreen.main.bounds
            let widthValue = (screenSize.width / 1.0)
            
            return CGSize(width: widthValue, height: widthValue/2)
          
        }else{
            
            let screenSize = UIScreen.main.bounds
            let widthValue = (screenSize.width / 5.0)
            
            return CGSize(width: widthValue, height: widthValue)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    
    func getAllTopSellSneakers(){
        
        SneakerService.getSneakers{[weak self] (topSellSneaker) in
            self?.topSellSneaker = topSellSneaker
        }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let detailVC = segue.destination as! DetailTopSellController
//        let cell = sender as! TopCellViewCell
//        let index = topSellCView?.indexPath(for: cell)
//        detailVC.sneakerDetail = topSellSneaker[(index?.row)!]
//
//    }
    
    
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
        let cell = sender as! TopCellViewCell
        let index = topSellCView?.indexPath(for: cell)
        detailVC.sneakerDetail = topSellSneaker[(index?.row)!]
    }
    
    
    func getDataSneakerFirebase(){
        ref = Database.database().reference(withPath: "sneaker-db")
        
        ref.observe(.value, with: { snapshot in
            print(snapshot.value as Any)
            
            
            for child in snapshot.children {
                // 4
                if let snapshot = child as? DataSnapshot,
                    let sneakerFirebaseItem = SneakerFirebase(snapshot: snapshot) {
                    self.topSellSneakerFirebase.append(sneakerFirebaseItem)
                }
            }
        })
        
        print(topSellSneakerFirebase.count)
    }
    
    
    func base64Convert(base64String: String?) -> UIImage{
        if (base64String?.isEmpty)! {
            return #imageLiteral(resourceName: "no_image_found")
        }else {
            // !!! Separation part is optional, depends on your Base64String !!!
            let temp = base64String?.components(separatedBy: ",")
            let dataDecoded : Data = Data(base64Encoded: temp![1], options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            return decodedimage!
        }
    }
    
    func getImageFromBase64(base64:String) -> UIImage {
        let data = Data(base64Encoded: base64)
        return UIImage(data: data!)!
    }
    
    
    
}
