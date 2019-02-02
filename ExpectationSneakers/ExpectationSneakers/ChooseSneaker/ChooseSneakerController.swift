//
//  DetailTopSellController.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/4/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit
import Firebase

class ChooseSneakerController : UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var detailPhoto: UIImageView!
    @IBOutlet weak var modelLabel: UILabel!
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    @IBOutlet weak var sizeInfoLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    @IBOutlet weak var ModelName: UILabel!
    @IBOutlet weak var Pricelabel: UILabel!
    @IBOutlet weak var tallaARK: UIButton!
    @IBOutlet weak var addToCar: UIButton!
    
    
    var sneakerDetail: Sneaker?
    var sneakerDetailFirebase: SneakerFirebase?
    //Reference to size catalog node from sneaker node child
    var refCatSize: DatabaseReference!
    var refCart: DatabaseReference!
    var sizeCollection = [SizeFirebase]()
    var sizesChoose = [SizeFirebase]()
    var carFirebas: CartFirebase?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.tabBarController?.tabBar.isHidden = true
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self        
        detailPhoto.image = getImageFromBase64(base64: (sneakerDetailFirebase?.image64)!)
        modelLabel.text = sneakerDetailFirebase?.model
        priceLabel.text = ("$" + (sneakerDetailFirebase?.price.description)!)
        refCart = Database.database().reference(withPath: "cart-db")
        getDataSizeFirebase()
        
        
        tallaARK.layer.cornerRadius = 5
        tallaARK.layer.borderWidth = 1
        tallaARK.layer.borderColor = UIColor.lightGray.cgColor
        
        addToCar.layer.cornerRadius = 5
        addToCar.layer.borderWidth = 1
        addToCar.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        //guard let sneakerDetail = sneakerDetail else {return 0}
        return sizeCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cellSize", for: indexPath) as! SizeViewCell
        cell.sizeCellLabel.text = sizeCollection[indexPath.row].size //.sizes[indexPath.row].size
        cell.propiertiesSizeCell(label: cell.sizeCellLabel)
        
       
        
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
    
    func getImageFromBase64(base64:String) -> UIImage {
        let data = Data(base64Encoded: base64)
        return UIImage(data: data!)!
    }
    
    func getDataSizeFirebase(){
        refCatSize = Database.database().reference(withPath: "sneaker-db").child((sneakerDetailFirebase?.key)!).child("sizesAvailable")
        //get data from catalog node
        refCatSize.observe(.value, with: { snapshot in
            var newItems: [SizeFirebase] = []
            for child in snapshot.children {
                if let snapshot = child as? DataSnapshot,
                    let sizeFirebaseItem = SizeFirebase(snapshot: snapshot) {
                    newItems.append(sizeFirebaseItem)
                }
            }
            //once all data load from database , sorted size-array and add to array of size object
            self.sizeCollection = newItems.sorted(by: { $0.size < $1.size })
            //reload the collection view once all data are load and sorted
            //self.sizesChoose = self.sizeCollection
            for var sizeChooseItem in self.sizeCollection{
                sizeChooseItem.count = 0
                self.sizesChoose.append(sizeChooseItem)
            }
            self.sizeCollectionView.reloadData()
            
           
        })
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "There are \(sizeCollection[indexPath.row].count) items on stock",
                                      message: "Add a Quantity",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let textField = alert.textFields![0]
            let valor = Int(textField.text!) ?? 0
            self.sizesChoose[indexPath.row].count = valor
            
        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func addToCart(_ sender: Any) {
        
       if (!validSizeArrayAvailable()){
            let alert = UIAlertController(title: "Oops", message: "Please choose a size", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        else{
            
        let cartItem = CartFirebase(model: (sneakerDetailFirebase?.model)!, price: Double((sneakerDetailFirebase?.price)!))
        
        if (idTransaction.id == "" ){
            idTransaction.id = self.refCart.childByAutoId().key!
        }
            // 3
        let refCart = self.refCart.child(idTransaction.id).child((sneakerDetailFirebase?.model)!.lowercased())
            refCart.setValue(cartItem.toAnyObject()) {
                (error:Error?, refCart:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error).")
                } else {
                    print("Added to Cart!")
                    //Add sizes to sneaker and save on database
                    self.saveSneakerSizes(modelSneaker: (self.sneakerDetailFirebase?.model.lowercased())!, referenceCart: refCart)
                    let alert = UIAlertController(title: "Saved", message: "Snaker info was saved", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func saveSneakerSizes(modelSneaker:String, referenceCart: DatabaseReference){
        for size in self.sizesChoose {
            if size.count != 0 {
                let sizeItem = SizeFirebase(size: size.size, count: size.count, sizeCM: size.sizeCM)
                let sizeItemRef = referenceCart.child("sizesAvailable").child(size.size.replacingOccurrences(of: ".", with: "-").lowercased())
                sizeItemRef.setValue(sizeItem.toAnyObject())
                //self.sizesAvailable.remove(at: itemIndex)
            }
        }
    }
    
    func validSizeArrayAvailable()-> Bool{
        var result: Bool = false
        for size in self.sizesChoose {
            if size.count != 0 {
                result = true
            }
        }
        return result
    }
}
