//
//  LoadSneakerUser.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/13/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//


import UIKit
import Firebase

class LoadSneakerUser: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UICollectionViewDataSource, UICollectionViewDelegate  {
    //Reference to sneaker-node from firebase database
    var ref: DatabaseReference!
    //Instance from picker a image a load to firebase
    let imagePickerController = UIImagePickerController()
    //Reference to size catalog node from firebase database
    var refCatSize: DatabaseReference!
    //array of sizes to load data from catalogue
    var sizeCollection = [SizeFirebase]()
    var sizesAvailable = [SizeFirebase]()
    @IBOutlet weak var sizeCollectionView: UICollectionView!
    
    @IBOutlet weak var labelModel: UITextField!
    @IBOutlet weak var labelPrice: UITextField!
    @IBOutlet weak var pickedImage: UIImageView!
    @IBOutlet weak var labelBrand: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        sizeCollectionView.delegate = self
        sizeCollectionView.dataSource = self
        ref = Database.database().reference(withPath: "sneaker-db")
        getDataSizeFirebase()
        
    }
    
    func getDataSizeFirebase(){
        refCatSize = Database.database().reference(withPath: "cat-size-db")
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
            self.sizeCollectionView.reloadData()
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func validSizeArrayAvailable()-> Bool{
        var index = 0
        for size in self.sizeCollection {
            if size.count != 0 {
                self.sizesAvailable.append(size)
                self.sizeCollection[index].count = 0
            }
            index = index + 1
        }
        if self.sizesAvailable.count != 0 {
            return true
        }
        else{
            return false
        }
    }
    
    //function from button to add a sneaker to firebase database
    @IBAction func add(_ sender: Any) {
    
        if(labelModel.text == ""){
            let alert = UIAlertController(title: "Oops", message: "Please enter a model", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }else if (labelPrice.text == ""){
            let alert = UIAlertController(title: "Oops", message: "Please enter a price", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }else if (labelBrand.text == ""){
            let alert = UIAlertController(title: "Oops", message: "Please enter a brand", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }else if (pickedImage.image == nil){
            let alert = UIAlertController(title: "Oops", message: "Please pick an image", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }else if (!validSizeArrayAvailable()){
            let alert = UIAlertController(title: "Oops", message: "Please choose an size", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        else{
            let imageExample: UIImage = pickedImage.image!
            let base64String = convertImageTobase64(format: .jpeg(0.8), image: imageExample)
            
            ////
            
            // 1
            guard let modelField = labelModel,
                let model = modelField.text else { return }
            
            guard let priceField = labelPrice,
                let price = priceField.text else { return }
            
            guard let brandField = labelBrand,
                let brand = brandField.text else { return }
            
            // 2
            
            let sneakerItem = SneakerFirebase(model: model, price: Double(price)!, brand: brand, image: base64String!)
            
            // 3
            let sneakerItemRef = self.ref.child(model.lowercased())
            sneakerItemRef.setValue(sneakerItem.toAnyObject()) {
                (error:Error?, ref:DatabaseReference) in
                if let error = error {
                    print("Data could not be saved: \(error).")
                } else {
                    print("Data saved successfully!")
                    //Add sizes to sneaker and save on database
                    self.saveSneakerSizes(modelSneaker: model.lowercased())
                    let alert = UIAlertController(title: "Saved", message: "Snaker info was saved", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .cancel, handler: nil))
                    self.present(alert, animated: true)
                }
            }
        }
    }
    
    func saveSneakerSizes(modelSneaker:String){
        let itemIndex = 0
        for size in self.sizesAvailable {
            if size.count != 0 {
                let sizeItem = SizeFirebase(size: size.size, count: size.count, sizeCM: size.sizeCM)
                let sizeItemRef = self.ref.child(modelSneaker).child("sizesAvailable").child(size.size.replacingOccurrences(of: ".", with: "-").lowercased())
                sizeItemRef.setValue(sizeItem.toAnyObject())
                self.sizesAvailable.remove(at: itemIndex)
            }
        }
    }
    
    
    func convertImageTobase64(format: ImageFormat, image:UIImage) -> String? {
        var imageData: Data?
        switch format {
        case .png: imageData = UIImage.pngData(image)()
        case .jpeg(let compression): imageData = UIImage.jpegData(image)(compressionQuality: compression)
            
            
        }
        return imageData?.base64EncodedString()
    }
    
    
    public enum ImageFormat {
        case png
        case jpeg(CGFloat)
    }
   
    
    @IBAction func pickImage(_ sender: Any) {
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var newImage: UIImage
        
        if let possibleImage = info[.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[.originalImage] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        // do something interesting here!
        print(newImage.size)
        pickedImage.image = newImage
        
        dismiss(animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sizeCollection.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "cellSize", for: indexPath) as! SizeViewCell
        cell.sizeLoadCellLabel.text = sizeCollection[indexPath.row].size
        
        cell.propiertiesSizeCell(label: cell.sizeLoadCellLabel)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
   
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(sizeCollection[indexPath.row].size)
        let alert = UIAlertController(title: "Quantity Sizes Available",
                                      message: "Add a Quantity",
                                      preferredStyle: .alert)
        let saveAction = UIAlertAction(title: "Save", style: .default) { _ in
            let textField = alert.textFields![0]
            let valor = Int(textField.text!) ?? 0
            self.sizeCollection[indexPath.row].count = valor

        }
        
        let cancelAction = UIAlertAction(title: "Cancel",
                                         style: .cancel)
        
        alert.addTextField()
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}

