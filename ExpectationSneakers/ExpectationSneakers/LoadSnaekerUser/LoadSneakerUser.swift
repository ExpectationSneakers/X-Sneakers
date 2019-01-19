//
//  LoadSneakerUser.swift
//  ExpectationSneakers
//
//  Created by Edgar Barragan on 1/13/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//


import UIKit
import Firebase

class LoadSneakerUser: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    var items: [SneakerFirebase] = []
    //let ref = Database.database().reference(withPath: "grocery-items")
    
    var ref: DatabaseReference!
    
    let imagePickerController = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        ref = Database.database().reference(withPath: "sneaker-db")
        
        
//        ref.observe(.value, with: { snapshot in
//            print(snapshot.value as Any)
//        })
    }
    
    
    
    @IBOutlet weak var labelModel: UITextField!
    @IBOutlet weak var labelPrice: UITextField!
    @IBOutlet weak var txtEmailID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtConfirmPassword: UITextField!
    @IBOutlet weak var pickedImage: UIImageView!
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func add(_ sender: Any) {
        print("texto: \((labelModel.text)!)")
        
        if(labelModel.text == ""){
            let alert = UIAlertController(title: "Oops", message: "Please enter the model", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }else if ((labelPrice.text) == ""){
            let alert = UIAlertController(title: "Oops", message: "Please enter the price", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: nil))
            self.present(alert, animated: true)
            
        }
        else{
            
            ////
            
            let imageExample: UIImage = pickedImage.image!
            
            let base64String = convertImageTobase64(format: .jpeg(0.8), image: imageExample)
            
            ////
            
            // 1
            guard let modelField = labelModel,
                let model = modelField.text else { return }
            
            guard let priceField = labelPrice,
                let price = priceField.text else { return }
            
            // 2
            let sneakerItem = SneakerFirebase(model: model, price:  Double(price)!, description: "pruebaImagen", image: base64String!)
            
            // 3
            let sneakerItemRef = self.ref.child(model.lowercased())
            
            // 4
            sneakerItemRef.setValue(sneakerItem.toAnyObject())
            
            
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
    
}

