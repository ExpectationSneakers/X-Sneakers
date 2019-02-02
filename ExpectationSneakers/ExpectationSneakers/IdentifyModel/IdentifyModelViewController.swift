//
//  IdentifyModelViewController.swift
//  ExpectationSneakers
//
//  Created by Brian Morales on 2/1/19.
//  Copyright © 2019 Brian Morales. All rights reserved.
//

import UIKit
import Vision
import CoreML

class IdentifyModelViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    
    @IBOutlet weak var dataImage: UIImageView!
    
    @IBOutlet weak var dataLabel: UILabel!
    
    @IBOutlet weak var camaraButton: UIButton!
    @IBOutlet weak var galeriaButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        detectarImagenes()
        
        
        camaraButton.layer.cornerRadius = 5
        camaraButton.layer.borderWidth = 1
        camaraButton.layer.borderColor = UIColor.lightGray.cgColor
        
        galeriaButton.layer.cornerRadius = 5
        galeriaButton.layer.borderWidth = 1
        galeriaButton.layer.borderColor = UIColor.lightGray.cgColor
        
        dataLabel.layer.cornerRadius = 5
        dataLabel.layer.borderWidth = 1
        dataLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        dataImage.layer.cornerRadius = 5
        dataImage.layer.borderWidth = 1

        // Do any additional setup after loading the view.
    }
    
    @objc func fbButtonPressed() {
        
        print("Share to fb")
    }
    
    @IBAction func tomarFoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.camera){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }else{
            print("No se pudo acceder a la camara")
        }
    }
    
    @IBAction func seleccionarFoto(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
            
        }else{
            print("No se pudo acceder a Fotos")
        }
    }
    
    
    func detectarImagenes(){
        dataLabel.text = "Cargando..."
        guard let model = try? VNCoreMLModel(for: ImageClassifier().model) else{
            print("No se pudo crear el modelo")
            return
        }
        
        let peticion = VNCoreMLRequest(model: model) { (request,error) in
            guard let resultados = request.results as? [VNClassificationObservation], let primerResultado = resultados.first else{
                print("No se encontraron resultados")
                return
            }
            
            DispatchQueue.main.async {
                self.dataLabel.text = "\(primerResultado.identifier)"
            }
        }
        
        
        guard let ciimageForUse = CIImage(image: self.dataImage.image!) else {
            print("No se cargo imagen correctamente")
            return
        }
        
        
        let handler = VNImageRequestHandler(ciImage: ciimageForUse)
        
        DispatchQueue.global().async {
            do{
                try handler.perform([peticion])
            }catch{
                print(error.localizedDescription)
            }
        }
        
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]){
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            self.dataImage.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
        
        detectarImagenes()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
